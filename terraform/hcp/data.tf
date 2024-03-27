data "hcp_packer_version" "acme_frontend" {
  bucket_name  = var.hcp_bucket_acme_images
  channel_name = var.hcp_channel
}

data "hcp_packer_artifact" "aws_acme_frontend" {
  bucket_name         = data.hcp_packer_version.acme_frontend.bucket_name
  version_fingerprint = data.hcp_packer_version.acme_frontend.fingerprint
  platform            = "aws"
  region              = var.aws_region
}

data "hcp_packer_artifact" "gcp_acme_frontends" {
  bucket_name         = data.hcp_packer_version.acme_frontend.bucket_name
  version_fingerprint = data.hcp_packer_version.acme_frontend.fingerprint
  platform            = "gcp"
  region              = var.gcp_region
}