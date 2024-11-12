variable "connection_name" {
  description = "Name of the Cloud Build connection"
  type        = string
}

variable "connection_region" {
  description = "Region of the Cloud Build connection"
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
