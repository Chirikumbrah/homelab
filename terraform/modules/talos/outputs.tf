# kubeconfig and secrets as outputs
output "talosconfig" {
  description = "Talos client configuration"
  value       = data.talos_machine_secrets.cluster.client_configuration
  sensitive   = true
}

output "kubeconfig" {
  description = "Kubernetes kubeconfig"
  value       = data.talos_cluster_kubeconfig.cluster.kube_config
}

output "machine_secrets" {
  description = "Talos machine secrets"
  value       = data.talos_machine_secrets.cluster.machine_secrets
  sensitive   = true
}
