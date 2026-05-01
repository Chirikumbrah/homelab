locals {
  host_entries = [
    for name, n in var.nodes : {
      ip       = n.address
      hostname = name
    }
  ]

  cp_node_ips = sort([
    for _, n in var.nodes : n.address if n.role == "controlplane"
  ])

  common_patch = templatefile("${path.module}/patches/common.yaml.tftpl", {
    install_image = var.talos_image
    install_disk  = var.install_disk
    host_entries  = local.host_entries
  })

  controlplane_patch = templatefile("${path.module}/patches/controlplane.yaml.tftpl", {
    vip                 = var.vip
    cp_node_ips         = local.cp_node_ips
    apiserver_cert_sans = var.apiserver_cert_sans
  })

  node_patch = {
    for name, _ in var.nodes :
    name => templatefile("${path.module}/patches/node.yaml.tftpl", { hostname = name })
  }
}

data "talos_machine_configuration" "controlplane" {
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "controlplane"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  kubernetes_version = var.kubernetes_version
  talos_version      = var.talos_version
  docs               = false
  examples           = false

  config_patches = [local.common_patch, local.controlplane_patch]
}

data "talos_machine_configuration" "worker" {
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "worker"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  kubernetes_version = var.kubernetes_version
  talos_version      = var.talos_version
  docs               = false
  examples           = false

  config_patches = [local.common_patch]
}

