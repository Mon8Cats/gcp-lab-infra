resource "google_sql_database_instance" "postgres_instance" {
  name             = var.instance_name
  database_version = var.database_version
  project          = var.project_id
  region           = var.region

  settings {
    tier            = var.tier
    availability_type = var.availability_type
    backup_configuration {
      enabled = true
    }
    ip_configuration {
      ipv4_enabled    = true
      private_network = var.enable_private_ip ? "projects/${var.project_id}/global/networks/${var.vpc_name}" : null

      #require_ssl     = true
    }
  }
}

resource "google_sql_database" "my_database" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres_instance.name
  project = var.project_id
}

resource "google_sql_user" "db_user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres_instance.name
  password = var.db_password
  project = var.project_id
}

