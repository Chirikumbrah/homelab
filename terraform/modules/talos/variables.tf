variable "talos_configs" {
  description = "Talos node configurations"
  type = object({
    global = object({
      node_name    = string
      datastore_id = string
    })
    configs = map(object({
      enabled              = bool
      node_ip              = string                 # VM IP from modules/vms/
      role                 = string                 # controlplane | worker
      bootstrap            = optional(bool, false)  # true for first VM (controlplane)
      extra_machine_config = optional(string, null) # YAML patches for machine config
      node_name            = optional(string, null)
      datastore_id         = optional(string, null)
    }))
  })
}

variable "talos_version" {
  description = "Talos version"
  type        = string
  default     = "v1.10.8"
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "homelab"
}

variable "cluster_endpoint" {
  description = "Cluster endpoint (https://LOAD_BALANCER_IP:6443)"
  type        = string
}

variable "vm_ids_dependency" {
  description = "Dependency on VM creation (pass proxmox_virtual_environment_vm.vms)"
  type        = any
}

