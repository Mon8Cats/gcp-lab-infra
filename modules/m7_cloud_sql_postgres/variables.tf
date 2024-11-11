variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region where the Artifact Registry is created"
  type        = string
  default     = "us-central1"
}


variable "instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "database_name" {
  description = "Name of the PostgreSQL database"
  type        = string
}

variable "db_user" {
  description = "PostgreSQL database username"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL database user password"
  type        = string
  sensitive   = true
}

variable "tier" {
  description = "Machine type tier (e.g., db-f1-micro, db-g1-small, db-n1-standard-1)"
  type        = string
  default     = "db-f1-micro"
}

variable "database_version" {
  description = "PostgreSQL version (e.g., POSTGRES_14)"
  type        = string
  default     = "POSTGRES_14"
}

variable "enable_private_ip" {
  description = "Enable private IP for Cloud SQL instance"
  type        = bool
  default     = false
}

variable "availability_type" {
  description = "Availability type (ZONAL or REGIONAL)"
  type        = string
  default     = "ZONAL"
}

variable "vpc_name" {
  description = "Name of the custom VPC network"
  type        = string
}

