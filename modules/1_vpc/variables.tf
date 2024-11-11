# variables.tf

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where the resources will be created"
  type        = string
  default     = "us-central1"  # Default can be overridden in .tfvars
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-custom-vpc"  # Default can be overridden
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "my-custom-subnet"  # Default can be overridden
}

variable "subnet_cidr" {
  description = "The IP CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"  # Default CIDR block
}
