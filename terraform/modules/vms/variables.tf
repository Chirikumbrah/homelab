variable "vm_name" {
  description = "VM name"
  type        = string
  default     = null
}

variable "node_name" {
  description = "Node name where VM will be created"
  type        = string
  default     = null
}

variable "vm_tags" {
  description = "Tags to be associated with the VM"
  type        = list(string)
  default     = null
}

variable "vm_id" {
  description = "VM ID"
  type        = number
  default     = null
}

variable "cores_count" {
  description = "Number of CPU cores for the VM"
  type        = number
  default     = null
}

variable "ram_amount" {
  description = "Amount of RAM for the VM"
  type        = number
  default     = null
}

variable "disk_size" {
  description = "Size of the disk for the VM"
  type        = number
  default     = null
}

variable "vm_ip_address" {
  description = "IP address for the VM"
  type        = string
  default     = null
}

variable "ssh_public_key" {
  description = "Public key for SSH access"
  type        = string
  default     = null
}

variable "vm_username" {
  description = "Username for the VM user"
  type        = string
  default     = "root"
}

variable "vm_password" {
  description = "Password for the VM"
  type        = string
  default     = null
}

variable "image_file_path" {
  description = "Path to the image file"
  type        = string
  default     = null
}

variable "vm_pool_id" {
  description = "Pool ID where the VM will be created"
  type        = string
  default     = null
}

variable "vm_description" {
  description = "VM description"
  type        = string
  default     = null
}

variable "gateway_ip" {
  description = "Gateway IP address for the VM network"
  type        = string
  default     = "10.20.30.111"
}

variable "dns_servers" {
  description = "DNS servers for VM"
  type        = list(string)
  default     = ["10.20.30.170", "10.20.30.111"]
}

variable "datastore_id" {
  description = "Datastore ID for VM disk storage"
  type        = string
  default     = "local-lvm"
}
