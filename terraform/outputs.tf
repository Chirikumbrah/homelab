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
    kubeconfig   = "${path.module}/generated/kubeconfig"
    talosconfig  = "${path.module}/generated/talosconfig"
    controlplane = "192.168.1.111"
    workers      = ["192.168.1.112"]
    endpoint     = var.k8s_cluster_endpoint
    vm_ids       = module.vms.vm_ids
  }
}

output "machine_secrets" {
  description = "Talos machine secrets (sensitive)"
  value       = module.talos.machine_secrets
  sensitive   = true
}

