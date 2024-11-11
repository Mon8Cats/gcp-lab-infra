
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_ip_range" {
  description = "CIDR range of the subnet"
  type        = string
}

variable "subnet_region" {
  description = "Region for the subnet"
  type        = string
}

variable "network_self_link" {
  description = "Self-link of the VPC network"
  type        = string
}

variable "project_id" {
  description = "Project ID for the subnet"
  type        = string
}
