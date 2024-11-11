# modules/api_enablement/main.tf

/*
resource "google_cloudbuildv2_connection" "github_connection" {
  provider = google
  name     = "projects/${var.project_id}/locations/${var.region}/connections/github-connection"
  location = var.region
  github_config {
    app_id               = var.github_app_id
    installation_id      = var.github_app_installation_id
    private_key_secret_version = "projects/${var.project_id}/secrets/github-private-key/versions/latest"
    client_id_secret_version   = "projects/${var.project_id}/secrets/github-client-id/versions/latest"
    client_secret_version      = "projects/${var.project_id}/secrets/github-client-secret/versions/latest"
  }
}

# Store the private key, client ID, and secret in GCP Secret Manager
resource "google_secret_manager_secret" "github_private_key" {
  secret_id = "github-private-key"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "github_private_key_version" {
  secret      = google_secret_manager_secret.github_private_key.id
  secret_data = var.github_app_private_key
}

resource "google_secret_manager_secret" "github_client_id" {
  secret_id = "github-client-id"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "github_client_id_version" {
  secret      = google_secret_manager_secret.github_client_id.id
  secret_data = var.github_app_client_id
}

resource "google_secret_manager_secret" "github_client_secret" {
  secret_id = "github-client-secret"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "github_client_secret_version" {
  secret      = google_secret_manager_secret.github_client_secret.id
  secret_data = var.github_app_client_secret
}

resource "google_cloudbuildv2_repository" "github_repository" {
  name      = "projects/${var.project_id}/locations/${var.region}/connections/github-connection/repositories/${var.repo_name}"
  connection = google_cloudbuildv2_connection.github_connection.name
  location  = var.region

  github_config {
    repository = "${var.github_owner}/${var.repo_name}"  # Example: 'my-github-username/my-repo'
  }
}


resource "google_cloudbuild_trigger" "github_trigger" {
  name = "github-trigger"
  description = "Trigger build on code push to GitHub"
  github {
    owner      = var.github_owner
    name       = var.github_repo_name
    push {
      branch = "^main$"  # Trigger build only on push to the main branch
    }
  }

  # Build configuration
  filename = "cloudbuild.yaml"  # Path to your Cloud Build YAML file in the repo
}
*/