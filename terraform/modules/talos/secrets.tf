# Imported from existing cluster on first apply:
#   terraform import 'module.talos.talos_machine_secrets.this' generated/secrets.yaml
resource "talos_machine_secrets" "this" {
  talos_version = var.talos_version
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for n in var.nodes : n.address if n.role == "controlplane"]
  nodes                = [for n in var.nodes : n.address]
}

resource "local_sensitive_file" "talosconfig" {
  content  = data.talos_client_configuration.this.talos_config
  filename = "${path.root}/generated/talosconfig"
}

