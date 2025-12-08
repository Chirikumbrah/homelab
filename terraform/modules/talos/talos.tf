terraform {
  required_providers {
    proxmox = { source = "bpg/proxmox" }
    talos   = { source = "siderolabs/talos" }
  }
}

locals {
  enabled_configs = {
    for key, config in var.talos_configs.configs : key => config
    if config.enabled
  }
}

data "talos_machine_secrets" "cluster" {
  talos_version = var.talos_version
}

data "talos_machine_configuration" "configs" {
  for_each = local.enabled_configs

  cluster_name     = var.cluster_name
  cluster_endpoint = var.cluster_endpoint # e.g. https://LOAD_BALANCER:6443
  machine_type     = each.value.role      # controlplane or worker
  machine_secrets  = data.talos_machine_secrets.cluster.machine_secrets
  talos_version    = var.talos_version

  extra_machine_config = each.value.extra_machine_config
  extra_cluster_config = var.extra_cluster_config
}

resource "talos_machine_configuration_apply" "configs" {
  for_each = local.enabled_configs

  node                        = each.value.node_ip
  client_configuration        = data.talos_machine_secrets.cluster.client_configuration
  machine_configuration_input = data.talos_machine_configuration.configs[each.key].machine_configuration

  depends_on = [var.vm_ids_dependency] # waiting for VMs to start
}

# First k8s node bootstrap
resource "talos_machine_bootstrap" "controlplane" {
  for_each = {
    for key, config in local.enabled_configs : key => config
    if config.role == "controlplane" && config.bootstrap
  }

  node                 = each.value.node_ip
  client_configuration = data.talos_machine_secrets.cluster.client_configuration

  depends_on = [talos_machine_configuration_apply.configs]
}

# Getting kubeconfig
data "talos_cluster_kubeconfig" "cluster" {
  depends_on           = [talos_machine_bootstrap.controlplane]
  client_configuration = data.talos_machine_secrets.cluster.client_configuration
}

