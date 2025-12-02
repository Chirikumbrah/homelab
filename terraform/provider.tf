# https://registry.terraform.io/providers/bpg/proxmox/latest/docs
terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

provider "proxmox" {
  endpoint = var.var.proxmox_endpoint
  insecure = true
  username = var.proxmox_username
  password = var.var.proxmox_password
}
