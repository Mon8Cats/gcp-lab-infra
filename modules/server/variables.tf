variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "zone" {
  description = "GCP zone for the instance"
  type        = string
}

variable "subnet_self_link" {
  description = "Self link of the subnet for network interface"
  type        = string
}
