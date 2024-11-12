resource "google_cloudbuildv2_connection" "github_connection" {
  provider    = google-beta
  name        = var.connection_name
  location      = var.region

  github {
    authorizer_credential {
      github_app_installation_id  = var.github_app_installation_id
      access_token_secret_version = "projects/${var.project_id}/secrets/${var.github_token_secret}/versions/latest"
    }
  }
}

output "connection_name" {
  value = google_cloudbuildv2_connection.github_connection.name
}

output "connection_region" {
  value = google_cloudbuildv2_connection.github_connection.region
}
