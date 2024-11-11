
/*
# not support now
resource "google_cloudbuild_github_enterprise_config" "github_connection" {
  project = var.project_id
  host_url = "https://github.com"

  oauth_client_id     = var.github_oauth_client_id
  oauth_client_secret = var.github_oauth_client_secret
}
*/


resource "google_cloudbuild_trigger" "github_trigger" {
  project   = var.project_id
  name      = var.trigger_name
  
  github {
    owner  = var.github_owner  # Your GitHub user or organization
    name   = var.github_repo_only     # Repository name
    push {
      branch = "^main$"        # Watches for changes on the main branch
    }
  }

  # Specifies the build configuration file (cloudbuild.yaml) located in the root of your repository.
  filename = "cloudbuild.yaml"

  # The service account used to execute the Cloud Build job
  service_account = "projects/${var.project_id}/serviceAccounts/${var.cloudbuild_service_account_email}"
}
