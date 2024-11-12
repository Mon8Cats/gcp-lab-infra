
variable "secret_id" {
  description = "ID of the GitHub token secret in Secret Manager"
  type        = string
}

variable "service_account_email" {
  description = "Custom service account email for Cloud Build"
  type        = string
}
