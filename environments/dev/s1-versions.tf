# Terraform Settings Block
terraform {
  required_version = ">= 1.9"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">= 6.0.0"
    }
  }
  backend "gcs" {
    bucket = "win-gke-infra"
    prefix = "dev/gke-cluster"    
  }
}

# Terraform Provider Block
provider "google" {
  project = var.project_id
  region = var.project_region
}