terraform {
  cloud {
    organization = "acme-corp-org"

    workspaces {
      name = "acme-corp-tf-aws"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.82.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.default_tags
  }
}

provider "hcp" {
  client_id     = "oxzkG6KYFa1gKcB7wms4E19PTQHTJLDD"
  client_secret = "An8XqtOnjnRSIoxdkkQsazCapRyMz7BPymlY_TEhVidZ2K5-sZkc3CtetuJLNcNp"
}
