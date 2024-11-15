variable "db_instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
}

variable "region" {
  description = "The region for the Cloud SQL instance"
  type        = string
}

variable "db_machine_type" {
  description = "The machine type (e.g., db-f1-micro, db-g1-small, db-n1-standard-1)"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}
