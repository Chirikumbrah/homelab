variable "talos_release" {
  description = "Talos schema version (vX.Y.P)"
  type        = string
}

variable "install_platform" {
  description = "Talos image factory platform (nocloud for Proxmox qcow2 import)."
  type        = string
  default     = "nocloud"
}
