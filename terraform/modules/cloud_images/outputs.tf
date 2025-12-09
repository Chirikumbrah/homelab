output "downloaded_image_files" {
  description = "List of downloaded image file names"
  value = [
    for key, image in proxmox_virtual_environment_download_file.cloud_images : image.file_name
  ]
}

output "image_ids" {
  description = "Map of image name => volume ID"
  value = {
    for name, res in proxmox_virtual_environment_download_file.cloud_images :
    name => res.id
  }
}
