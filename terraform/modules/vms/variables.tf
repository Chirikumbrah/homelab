variable "vms_config" {
  description = "Configuration object containing VMs and global settings from YAML file"
  type = object({
    global = object({
      node_name        = string
      datastore_id     = string
      gateway          = string
      dns_servers      = list(string)
      cores            = number
      ram              = number
      disk_size        = number
      pool_id          = optional(string)
      boot_order       = list(string)
      startup_order    = number
      startup_up_delay = number
      cpu_type         = string
      network_bridge   = string
      os_type          = string
    })
    tags = list(string)
    vms = map(object({
      enabled       = bool
      vm_id         = number
      vm_ip_address = string
      tags          = optional(list(string))
      description   = optional(string)
      # Allow overriding global settings per VM
      node_name        = optional(string)
      datastore_id     = optional(string)
      gateway          = optional(string)
      dns_servers      = optional(list(string))
      cores            = optional(number)
      ram              = optional(number)
      disk_size        = optional(number)
      pool_id          = optional(string)
      boot_order       = optional(list(string))
      startup_order    = optional(number)
      startup_up_delay = optional(number)
      cpu_type         = optional(string)
      network_bridge   = optional(string)
      os_type          = optional(string)
      # VM-specific settings
      ssh_public_key    = optional(string)
      vm_username       = optional(string)
      vm_password       = optional(string)
      image_file        = optional(string)
      user_data_file_id = optional(string)
    }))
  })
}

variable "image_ids" {
  description = "Map of image logical name => volume ID from images module"
  type        = map(string)
}
