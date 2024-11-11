variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "project_number" {
  description = "The Google Cloud project number"
  type        = string
}

variable "region" {
  description = "The region for the resources"
  type        = string
}


variable "pre_api_list" {
  type        = list(string)
  description = "A list of APIs"
  #default     = ["value1", "value2", "value3"]  # optional default value
}

variable "backend_bucket_name" {
  description = "The region for the resources"
  type        = string
}

variable "wi_sa_id" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_id" {
  description = "The region for the resources"
  type        = string
}

variable "wi_provider_id" {
  description = "The region for the resources"
  type        = string
}

variable "github_repository" {
  description = "The region for the resources"
  type        = string
}

variable "github_account" {
  description = "The GitHub Account"
  type        = string
}

variable "github_repo_only" {
  description = "The region for the resources"
  type        = string
}

variable "wi_sa_roles" {
  type    = list(string)
  default = [
    "roles/cloudbuild.builds.builder",
    "roles/source.reader",
    "roles/artifactregistry.reader",
    "roles/storage.admin",
    "roles/run.admin",
    "roles/container.developer",
    "roles/iam.serviceAccountUser"
  ]
}