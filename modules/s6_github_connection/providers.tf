terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.0.0"
    }
  }
}

/*
provider "google-beta" {
  project = var.project_id
  region  = var.region
}
*/