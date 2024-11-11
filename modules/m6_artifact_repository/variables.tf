variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region where the Artifact Registry is created"
  type        = string
  default     = "us-central1"
}

variable "repository_id" {
  description = "The name of the Artifact Registry repository"
  type        = string
}

variable "description" {
  description = "Description of the Artifact Registry repository"
  type        = string
  default     = "Docker repository for storing container images"
}

variable "mode" {
  description = "The mode of the repository (STANDARD or VPC)"
  type        = string
  default     = "STANDARD_REPOSITORY"
}

variable "labels" {
  description = "Labels for the Artifact Registry repository"
  type        = map(string)
  default     = {}
}

/*
variable "prevent_destroy" {
  description = "Whether to prevent the repository from being destroyed"
  type        = bool
  default     = false
}
*/
