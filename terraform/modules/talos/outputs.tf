# kubeconfig and secrets as outputs
output "talosconfig" {
  description = "Talos client configuration (talosconfig)"
  value       = data.talos_client_configuration.cluster.talos_config
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
