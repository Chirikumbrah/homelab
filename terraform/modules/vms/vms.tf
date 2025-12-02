terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.vm_name
  tags        = var.vm_tags
  node_name   = var.node_name
  vm_id       = var.vm_id
  description = var.vm_description
  pool_id     = var.vm_pool_id

  agent { enabled = false }

  startup {
    order    = "3"
    up_delay = "5"
  }

  cpu {
    cores = var.cores_count
    type  = "host"
  }

  memory { dedicated = var.ram_amount }

  disk {
    datastore_id = var.datastore_id
    interface    = "sata0"
    size         = var.disk_size
    file_id      = var.image_file_path
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.vm_ip_address
        gateway = var.gateway_ip
      }
    }

    user_account {
      keys     = [trimspace(var.ssh_public_key)]
      password = var.vm_password
      username = var.vm_username
    }
  }

  network_device { bridge = "vmbr0" }

  operating_system { type = "l26" }

  lifecycle {
    ignore_changes = [
      cpu["architecture"],
      initialization[0].dns[0].servers,
      initialization[0].user_account[0].keys,
    ]
  }
}

output "vm_id" {
  value = proxmox_virtual_environment_vm.vm.id
}

