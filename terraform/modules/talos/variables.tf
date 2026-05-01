variable "cluster_name" {
  description = "Talos cluster name (must match existing cluster for import)"
  type        = string
}

variable "cluster_endpoint" {
  description = "Kubernetes API endpoint URL, e.g. https://192.168.1.100:6443"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version (matches existing kubelet image tag)"
  type        = string
}

variable "talos_version" {
  description = "Talos schema version (vX.Y, no patch) — passed to talos_machine_configuration."
  type        = string
}

variable "talos_image" {
  description = "Effective Talos installer URL"
  type        = string
}

variable "install_disk" {
  description = "Block device Talos installer writes to."
  type        = string
  default     = "/dev/sda"
}

variable "vip" {
  description = "VIP address advertised by control-plane nodes"
  type        = string
}

variable "apiserver_cert_sans" {
  description = "Additional SANs for kube-apiserver cert (external DNS, etc.)"
  type        = list(string)
  default     = []
}

variable "nodes" {
  description = "Map of all Talos nodes"
  type = map(object({
    address = string # IP without CIDR
    role    = string # "controlplane" or "worker"
  }))
}
