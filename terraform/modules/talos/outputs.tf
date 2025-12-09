# kubeconfig and secrets as outputs
output "talosconfig" {
  description = "Talos client configuration"
  value       = talos_machine_secrets.cluster.client_configuration
  sensitive   = true
}

output "kubeconfig" {
  description = "Kubernetes kubeconfig"
  value       = talos_cluster_kubeconfig.cluster.kubeconfig_raw
}

output "machine_secrets" {
  description = "Talos machine secrets"
  value       = talos_machine_secrets.cluster.machine_secrets
  sensitive   = true
}
