locals {
  vms_config = yamldecode(file("${path.module}/configs/vms.yaml"))

  # Adding IPs from network.yaml to every VM
  vms_with_ip = {
    for key, vm in local.vms_config.vms : key => merge(vm, {
      vm_ip_address = local.network_config.network.nodes[key].ip
    })
  }
}

module "vms" {
  source = "./modules/vms"

  vms_config = merge(local.vms_config, {
    global = merge(local.vms_config.global, {
      gateway     = local.network_config.network.gateway
      dns_servers = local.network_config.network.dns_servers
    })
    vms = local.vms_with_ip
  })
}
