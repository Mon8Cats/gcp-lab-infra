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
