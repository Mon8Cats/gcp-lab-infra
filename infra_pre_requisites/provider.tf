provider "google" {
  project = var.project_id
  region  = var.region
  #project = "mon-infra-439715"  # Replace with actual project ID
  #region  = "us-central1"
}

# beta for cloud build 2nd gen
provider "google-beta" {
  project = var.project_id
  region  = var.region
  #project = "mon-infra-439715"  # Replace with actual project ID
  #region  = "us-central1"
}