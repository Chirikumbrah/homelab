resource "local_file" "kubeconfig" {
  content  = module.talos.kubeconfig
  filename = "${path.module}/generated/kubeconfig"
}

resource "local_file" "talosconfig" {
  content         = module.talos.talosconfig
  filename        = "${path.module}/generated/talosconfig"
  file_permission = "0600"
}

output "cluster_info" {
  value = {
    kubeconfig  = "${path.module}/generated/kubeconfig"
    talosconfig = "${path.module}/generated/talosconfig"
    nodes       = local.network_config.network.nodes
    cidr        = local.network_config.network.cidr
    endpoint    = "https://${local.network_config.network.nodes["talos-cp-01"].node_ip}:6443"
  }
}

output "machine_secrets" {
  description = "Talos machine secrets (sensitive)"
  value       = module.talos.machine_secrets
  sensitive   = true
}

