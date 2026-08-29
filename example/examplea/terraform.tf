# holden:ignore:HLD_TF_004: this is an example
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.31.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "7.31.0"
    }
  }
  required_version = ">= 1.5.0"
}
