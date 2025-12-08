locals {
  talos_config   = yamldecode(file("${path.module}/configs/talos.yaml"))
  network_config = yamldecode(file("${path.module}/configs/network.yaml"))

  # Adding node_ip from network.yaml
  talos_with_ip = {
    for key, config in local.talos_config.configs : key => merge(config, {
      node_ip = local.network_config.network.nodes[key].node_ip
    })
  }
}

module "talos" {
  source = "./modules/talos"

  talos_configs     = merge(local.talos_config, { configs = local.talos_with_ip })
  talos_version     = var.talos_version
  cluster_name      = var.k8s_cluster_name
  cluster_endpoint  = "https://${local.network_config.network.nodes["talos-cp-01"].node_ip}:6443"
  vm_ids_dependency = module.vms.vm_ids
}

