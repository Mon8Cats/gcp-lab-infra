variable "project_id" {
  description = "Project ID for the GCP project"
  type        = string
}

variable "project_region" {
  description = "Region in which GCP Resources to be created"
  type = string
  default = "us-east1"
}


variable "wi_sa_id" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_id" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_name" {
  description = "The region for the resources"
  type        = string
}

variable "wi_pool_provider_id" {
  description = "The region for the resources"
  type        = string
}


variable "github_account" {
  description = "The GitHub Account"
  type        = string
}

variable "github_repository" {
  description = "The region for the resources"
  type        = string
}

variable "github_repo_only" {
  description = "The region for the resources"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}


variable "subnet_region" {
  description = "Region for the subnet"
  type        = string
}


# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "sap"
}

# CIDR IP Ranges
variable "subnet_ip_range" {
  description = "Subnet IP range"
  type = string
  default = "10.129.0.0/20"
}

variable "pods_ip_range" {
  description = "Kubernetes Pods IP range"
  type = string
  default = "10.11.0.0/21"
}

variable "services_ip_range" {
  description = "Kubernetes Services IP range"
  type = string
  default = "10.12.0.0/21"
}

variable "master_ip_range" {
  description = "Kubernetes Master IP range"
  type = string
  default = "10.13.0.0/28"
}