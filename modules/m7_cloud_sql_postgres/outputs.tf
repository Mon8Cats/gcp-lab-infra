
output "instance_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = google_sql_database_instance.postgres_instance.connection_name
}

output "database_name" {
  description = "Name of the PostgreSQL database"
  value       = google_sql_database.my_database.name
}

output "db_user" {
  description = "PostgreSQL username"
  value       = google_sql_user.db_user.name
}
