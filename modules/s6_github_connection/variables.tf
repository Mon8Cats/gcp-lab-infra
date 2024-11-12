variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Region for the Cloud Build connection"
  type        = string
}


variable "connection_name" {
  description = "Cloud Build GitHub Connection Name"
  type        = string
}


variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
}

variable "github_token_secret" {
  description = "Name of the GitHub token secret in Secret Manager"
  type        = string
}