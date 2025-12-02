terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_pool" "pool" {
  comment = var.pool_comment
  pool_id = var.pool_id
}

output "pool_id" {
  value = proxmox_virtual_environment_pool.pool.pool_id
}
