variable "ssh_public_key" {
  description = "Public key for SSH access"
  type        = string
  default     = "ssh-ed25519 AAAA"
}

variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
  default     = "https://192.168.1.11:8006/"
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

variable "kubernetes_nodes" {
  type = list(object({
    name = string
    ip   = string
  }))
  default = [
    { name = "kube-node-01", ip = "192.168.1.111" },
    { name = "kube-node-02", ip = "192.168.1.112" },
    { name = "kube-node-03", ip = "192.168.1.113" }
  ]
}
