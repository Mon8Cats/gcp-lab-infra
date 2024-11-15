resource "google_sql_database_instance" "postgres_instance" {
  name             = var.instance_name
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = var.machine_type
  }
}

resource "google_sql_user" "db_user" {
  instance  = google_sql_database_instance.postgres_instance.name
  name      = var.db_username
  password  = var.db_password
}

output "instance_connection_name" {
  value = google_sql_database_instance.postgres_instance.connection_name
}