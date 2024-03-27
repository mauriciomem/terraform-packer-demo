terraform {
  cloud {
    organization = "acme-corp-org"

    workspaces {
      name = "acme-corp-tf-gcp"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.21.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.82.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "google" {
  project        = var.project_id
  region         = var.gcp_region
  default_labels = var.default_labels
}

provider "hcp" {
  client_id     = "oxzkG6KYFa1gKcB7wms4E19PTQHTJLDD"
  client_secret = "An8XqtOnjnRSIoxdkkQsazCapRyMz7BPymlY_TEhVidZ2K5-sZkc3CtetuJLNcNp"
}