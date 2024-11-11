variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "wi_pool_id" {
  description = "Id of the workload idenitity pool"
  type        = string
}

variable "wi_pool_name" {
  description = "name of the workload idenitity pool"
  type        = string
}

variable "wi_pool_provider_id" {
  description = "Id of the workload idenitity provider"
  type        = string
}

variable "github_repository" {
  description = "Name of the github_repository"
  type        = string
}



variable "service_account_id" {
  description = "Service account for Workload Identity "
  type        = string
}
