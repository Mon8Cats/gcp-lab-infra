variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "auto_create_subnetworks" {
  description = "Whether to automatically create subnetworks"
  type        = bool
  default     = false
}

variable "project_id" {
  description = "Project ID for the VPC"
  type        = string
}
