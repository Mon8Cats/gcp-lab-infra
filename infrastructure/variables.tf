variable "project_id" {
  description = "Project ID for the GCP project"
  type        = string
}

variable "project_region" {
  description = "Region in which GCP Resources to be created"
  type = string
  default = "us-east1"
}

variable "bucket_name" {
  description = "The region for the resources"
  type        = string
}

variable "api_list" {
  type        = list(string)
  description = "A list of APIs"
  #default     = ["value1", "value2", "value3"]  # optional default value
}