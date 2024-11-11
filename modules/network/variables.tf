variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block of the subnet"
  type        = string
}

variable "region" {
  description = "Region for the subnet"
  type        = string
}
