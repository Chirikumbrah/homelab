locals {
  talos_config = yamldecode(file("${path.module}/configs/talos.yaml"))
}

module "talos" {
  source = "./modules/talos"

  talos_configs     = local.talos_config
  talos_version     = var.talos_version
  cluster_name      = var.k8s_cluster_name
  cluster_endpoint  = var.k8s_cluster_endpoint
  vm_ids_dependency = module.vms.vm_ids
}

