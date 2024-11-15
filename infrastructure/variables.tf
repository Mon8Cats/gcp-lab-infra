# project info, terraform backet bucket
variable "project_id" {
  description = "Project ID for the GCP project"
  type        = string
}

variable "region" {
  description = "Region in which GCP Resources to be created"
  type = string
  default = "us-east1"
}

variable "bucket_name" {
  description = "The region for the resources"
  type        = string
}

# api
variable "api_list" {
  type        = list(string)
  description = "A list of APIs"
  #default     = ["value1", "value2", "value3"]  # optional default value
}


# service account
variable "cicd_sa_name" {
  description = "The ID of the service account to create (must be unique within the project)"
  type        = string
}

variable "cicd_sa_role_list" {
  type        = list(string)
  description = "A list of APIs"
  #default     = ["value1", "value2", "value3"]  # optional default value
}

# workload identity 

/*
variable "wi_sa_id" {
  description = "The region for the resources"
  type        = string
}
*/

variable "wi_pool_id" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_name" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_provider_id" {
  description = "The region for the resources"
  type        = string
}


/*
variable "github_account" {
  description = "The GitHub Account"
  type        = string
}
*/

variable "github_repository" {
  description = "The region for the resources"
  type        = string
}

/*
variable "github_repo_only" {
  description = "The region for the resources"
  type        = string
}
*/

variable "github_token_secret_id" {
  description = "The secret id for github token"
  type        = string
}

variable "github_app_installation_id" {
  description = "Project ID for the GCP project"
  type        = string
}


variable "db_username" {
  description = "Project ID for the GCP project"
  type        = string
  sensitive = true
}

variable "db_password" {
  description = "Project ID for the GCP project"
  type        = string
  sensitive = true
}