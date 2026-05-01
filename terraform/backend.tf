terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "hl-proxmox.tfstate"
    region = "auto"
    endpoints = {
      s3 = "https://fe1b693b4291ff2c8b0d269b8511f794.r2.cloudflarestorage.com"
    }
    encrypt                     = true
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}
