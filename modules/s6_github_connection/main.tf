resource "google_cloudbuildv2_connection" "github_connection" {
  provider    = google-beta.beta
  name        = var.connection_name
  location      = var.region

    github_config {
      app_installation_id       = var.github_app_installation_id
      access_token_secret       = "projects/${var.project_id}/secrets/${var.github_token_secret}/versions/latest"
  }
}
