locals {
  vms_config = yamldecode(file("./configs/vms.yaml"))
}
module "vms" {
  for_each = { for vm in(local.vms_config.vms != null ? local.vms_config.vms : []) : vm.vm_name => vm }
  source   = "git@github.com:Chirikumbrah/homelab.git//terraform/modules/vms?ref=v1.0.0"

  vm_name        = each.value.vm_name
  node_name      = try(each.value.node_name, "kube-node-01")
  vm_id          = each.value.vm_id
  cores_count    = try(each.value.cores_count, "4")
  ram_amount     = try(each.value.ram_amount, "12288")
  disk_size      = try(each.value.disk_size, 200)
  vm_ip_address  = each.value.vm_ip_address
  vm_tags        = concat(local.vms_config.vm_tags, each.value.vm_tags)
  vm_password    = var.vm_password
  ssh_public_key = file("~/.ssh/id_rsa.pub")
  image_file_name = try(
    module.images[each.value.image_file_name].images[each.value.node_name].id,
    module.images["debian12"].images[each.value.node_name].id
  )
  vm_pool_id     = try(each.value.vm_pool_id, null)
  vm_description = try(each.value.vm_description, null)
}
