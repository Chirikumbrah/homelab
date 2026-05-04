resource "talos_machine_configuration_apply" "this" {
  for_each = var.nodes

  client_configuration = talos_machine_secrets.this.client_configuration
  machine_configuration_input = each.value.role == "controlplane" ? (
    data.talos_machine_configuration.controlplane.machine_configuration
    ) : (
    data.talos_machine_configuration.worker.machine_configuration
  )
  node = each.value.address
  # "auto" — Talos сам решает, нужен ли reboot (certSAN/extraHostEntries — без reboot,
  # endpoint/install image — с reboot). Было "reboot" (всегда перезагружалось) — избыточно.
  apply_mode = "auto"

  config_patches = [local.node_patch[each.key]]

  on_destroy = {
    reset    = true
    graceful = true
    reboot   = true
  }

  timeouts = {
    create = "15m"
    update = "10m"
  }
}
