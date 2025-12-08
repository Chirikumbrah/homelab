variable "ssh_public_key" {
  description = "Public key for SSH access"
  type        = string
  default     = "ssh-ed25519 AAAA"
  sensitive   = true
}

variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
  default     = "https://192.168.1.11:8006/"
}

variable "vm_username" {
  description = "Username for the VM user"
  type        = string
  default     = "root"
}

variable "vm_password" {
  description = "Password for the VM"
  type        = string
  default     = ""
}

variable "proxmox_username" {
  description = "Proxmox API user"
  type        = string
  default     = "root@pam"
}

variable "proxmox_password" {
  description = "Proxmox API token"
  type        = string
  default     = ""
}

variable "talos_version" {
  description = "Talos Linux version"
  type        = string
  default     = "v1.11.5"
}

variable "k8s_cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "yrlab"
}

