output "repository_url" {
  description = "The URL of the created Artifact Registry repository"
  value       = google_artifact_registry_repository.docker_repository.name
}
