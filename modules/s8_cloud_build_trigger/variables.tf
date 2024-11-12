variable "trigger_name" {
  description = "Name of the Cloud Build trigger"
  type        = string
}

variable "region" {
  description = "Region for the Cloud Build trigger"
  type        = string
}

variable "github_owner" {
  description = "GitHub Owner/Username"
  type        = string
}

variable "repo_name" {
  description = "GitHub Repository Name"
  type        = string
}

variable "branch_pattern" {
  description = "Branch pattern for the trigger (e.g., ^main$)"
  type        = string
}

variable "build_config" {
  description = "Path to the Cloud Build configuration file"
  type        = string
}

variable "service_account_email" {
  description = "Service account email to use for the trigger"
  type        = string
}


