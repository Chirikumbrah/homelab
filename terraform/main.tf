locals { vms_config = yamldecode(file("./configs/vms.yaml")) }

module "talos_image_factory" {
  source = "./modules/talos_image_factory"
  # Installer URL рендерится модулем: factory.talos.dev/<platform>-installer/<schematic>:<talos_release>.
  # talos_version — schema (vX.Y), talos_release — конкретный тег релиза.
  talos_release = "v1.13.0"
}

module "cloud_images" {
  source = "./modules/cloud_images"

  images_config = {
    global = {
      node_name    = "yrlab1"
      datastore_id = "shared-nfs-yrlab1"
    }
    images = {
      "talos-longhorn" = {
        enabled      = true
        content_type = "import"
        url          = module.talos_image_factory.disk_image_url
        file_name    = "talos-longhorn.qcow2"
      }
    }
  }
}

module "vms" {
  source = "./modules/vms"

  vms_config = local.vms_config
  image_ids  = module.cloud_images.image_ids
}

resource "null_resource" "wait_for_nodes" {
  for_each = local.vms_config.vms

  provisioner "local-exec" {
    command = "until nc -z ${split("/", each.value.address)[0]} 50000; do sleep 5; done"
  }

  depends_on = [module.vms]
}

module "talos" {
  source = "./modules/talos"

  cluster_name     = "yrlab-k8s"
  cluster_endpoint = "https://192.168.1.110:6443" # VIP, не IP одной CP
  vip              = "192.168.1.110"

  # Installer URL рендерится модулем: factory.talos.dev/<platform>-installer/<schematic>:<talos_release>.
  # talos_version — schema (vX.Y), talos_release — конкретный тег релиза.
  kubernetes_version = "v1.36.0-rc.1"
  talos_version      = "v1.13"
  talos_image        = module.talos_image_factory.install_image

  # cluster_endpoint host (VIP) автоматически попадает в apiserver certSANs — дублировать не нужно
  apiserver_cert_sans = ["yrlab.net", "yrlab.local"]

  nodes = {
    for name, vm in local.vms_config.vms : name => {
      address = split("/", vm.address)[0]
      role    = startswith(name, "talos-cp") ? "controlplane" : "worker"
    } if vm.enabled && contains(coalesce(vm.tags, []), "talos")
  }
  depends_on = [null_resource.wait_for_nodes]
}

