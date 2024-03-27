project_id   = "acme-corp-gcp"
gcp_vpc_zone = "us-central1-a"
builder_sa   = "acme-tf-sa@acme-corp-gcp.iam.gserviceaccount.com"
aws_region   = "us-east-1"
aws_profile  = "318949518667_SuperAdminAccess"
aws_vpc_parent_network = {
  vpc_id    = "vpc-0642c5f4765054bcb"
  subnet_id = "subnet-0c2a77f1c081b6cc8"
}
new_image_name = "acmeimage"
version        = "v01"
app_name       = "trader"


gcp_packer_src = {
  source_image_family = "ubuntu-pro-2204-lts"
  image_description   = "ACME image built with HashiCorp Packer for GCP"
  ssh_username        = "ubuntu"
  tags                = ["packer"]
  machine_type        = "e2-standard-4"
  use_iap             = true
  use_os_login        = false
  metadata            = { enable-oslogin : "true" }
}

aws_packer_src = {
  image_virtualization_type = "hvm"
  image_name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  root_device_type          = "ebs"
  owners                    = ["099720109477"]
  most_recent               = true
  ami_description           = "ACME image built with HashiCorp Packer for AWS"
  instance_type             = "t3.large"
  ssh_username              = "ubuntu"
  ssh_agent_auth            = false
}