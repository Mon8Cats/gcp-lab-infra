variable "instance_name" {
  description = "The Cloud SQL instance name"
  type        = string
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "db_username" {
  description = "The database username"
  type        = string
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

