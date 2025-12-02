locals {
  pools_config = yamldecode(file("./configs/pools.yaml"))
}

module "pools" {
  for_each = { for pool in local.pools_config.pools : pool.pool_id => pool }
  source   = "git@github.com:Chirikumbrah/homelab.git//terraform/modules/pools?ref=v1.0.0"

  comment = each.pool_comment
  pool_id = each.pool_id
}

