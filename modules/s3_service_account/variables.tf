variable "project_id" {
  description = "The GCP project ID where the service account will be created"
  type        = string
}

variable "service_account_name" {
  description = "The ID of the service account to create (must be unique within the project)"
  type        = string
}

variable "display_name" {
  description = "The display name of the service account"
  type        = string
  default     = "My Service Account"
}

variable "description" {
  description = "Description of the service account"
  type        = string
  default     = "Service account created by Terraform"
}

variable "roles" {
  description = "List of IAM roles to assign to the service account"
  type        = list(string)
}
