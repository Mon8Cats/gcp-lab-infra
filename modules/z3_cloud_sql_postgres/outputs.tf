
output "instance_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = google_sql_database_instance.postgres_instance.connection_name
}

output "instance_name" {
  description = "Name of the PostgreSQL database"
  value       = google_sql_database_instance.postgres_instance.name
}
