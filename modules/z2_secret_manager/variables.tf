variable "project_id" {
  description = "The GCP project ID where the secret will be created"
  type        = string
}

/*
variable "secret_name" {
  description = "Name of the secret in Secret Manager"
  type        = string
}
*/

variable "secret_id" {
  description = "Name of the secret in Secret Manager"
  type        = string
}

variable "secret_data" {
  description = "Value of the secret to store in Secret Manager"
  type        = string
  sensitive   = true
}