output "disk_image_url" {
  value = replace(data.talos_image_factory_urls.this.urls["disk_image"], ".raw.xz", ".qcow2")
}

output "install_image" {
  description = "Effective Talos installer URL — use for `talosctl upgrade --image <URL>` (provider issue #140: config apply does NOT trigger OS upgrade)"
  value       = data.talos_image_factory_urls.this.urls.installer
}

