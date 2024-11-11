
# Step 1: Create Service Account for Workload Identity
resource "google_service_account" "ci_service_account" {
  account_id   = "ci-service-account"
  display_name = "CI Service Account for Workload Identity"
}

# Step 2: Assign Permissions to Service Account
# The service account needs permission to use Cloud Build, Artifact Registry, and Cloud Run
resource "google_project_iam_binding" "cloud_build_permissions" {
  project = var.project_id
  role    = "roles/cloudbuild.builds.editor"
  members = [
    "serviceAccount:${google_service_account.ci_service_account.email}"
  ]
}

resource "google_project_iam_binding" "artifact_registry_permissions" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  members = [
    "serviceAccount:${google_service_account.ci_service_account.email}"
  ]
}

resource "google_project_iam_binding" "cloud_run_permissions" {
  project = var.project_id
  role    = "roles/run.admin"
  members = [
    "serviceAccount:${google_service_account.ci_service_account.email}"
  ]
}
