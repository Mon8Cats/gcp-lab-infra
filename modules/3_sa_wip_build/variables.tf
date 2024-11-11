# variables.tf

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where the resources will be created"
  type        = string
  default     = "us-central1"  # Default can be overridden in .tfvars
}

variable "github_owner" {
  description = "The owner of the GitHub repository"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository name"
  type        = string
}