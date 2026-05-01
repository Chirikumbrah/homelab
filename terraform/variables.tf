variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
  default     = "https://192.168.1.11:8006/"
}

variable "proxmox_ssh_key_path" {
  description = "SSH private key for proxmox vm"
  type        = string
  default     = ""
  sensitive   = true
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

