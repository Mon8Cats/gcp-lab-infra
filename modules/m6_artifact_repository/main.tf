
resource "google_artifact_registry_repository" "docker_repository" {
  project       = var.project_id
  location      = var.region
  repository_id    = var.repository_id
  description      = var.description
  format           = "DOCKER"
  mode             = var.mode
  labels           = var.labels

  lifecycle {
    prevent_destroy = true #var.prevent_destroy
  }
}

