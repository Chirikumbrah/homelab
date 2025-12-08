locals {
  network_config = yamldecode(file("${path.module}/configs/network.yaml"))
}
