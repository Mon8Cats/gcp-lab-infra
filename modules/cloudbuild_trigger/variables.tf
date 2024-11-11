variable "project_id" {
  description = "GCP Project ID"
  type        = string
}


variable "github_owner" {
  description = "GitHub owner (user or organization)"
  type        = string
}

variable "github_repo_only" {
  description = "GitHub repository name"
  type        = string
}

/*

variable "github_repo_name" {
  type = string
}
*/

/*
variable "github_oauth_client_id" {
  type = string
}

variable "github_oauth_client_secret" {
  type = string
}
*/


variable "cloudbuild_service_account_email" {
  type = string
}

variable "trigger_name" {
  type = string
}
