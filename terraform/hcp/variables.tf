variable "hcp_bucket_acme_images" {
  type = string
  description = "HCP Packer bucket name for hashicups image"
  default     = "acme-corp-image-mgmt"
}

variable "hcp_channel" {
  type = string
  description = "HCP Packer channel name"
  default     = "development"
}
