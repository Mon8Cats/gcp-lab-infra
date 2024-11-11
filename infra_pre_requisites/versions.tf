# versions.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }

   backend "gcs" {
    bucket  = "win-gke-cicd-tf-backend" # The GCS bucket name
    prefix  = "terraform/state/infra"  # Path to the state file within the bucket (use different paths for different environments)
    #project = var.project_id    # The GCP project ID
  }
}

# do not use variables for bucket name and prefix