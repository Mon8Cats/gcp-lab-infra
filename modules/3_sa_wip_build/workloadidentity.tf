# Configure the Google Cloud provider
# Create a Workload Identity Pool
# Create a Workload Identity Pool Provider
# Create a Service Account
# Bind the service account to the Workload Identity Pool
# Create a GitHub Actions secret for the service account email





# Step 3: Create Workload Identity Pool
resource "google_iam_workload_identity_pool" "github_pool" {
  provider     = google
  project      = var.project_id
  #location     = "global"
  workload_identity_pool_id = "github-pool"
  display_name = "GitHub Workload Identity Pool"
}

# Step 4: Create Workload Identity Provider (for GitHub)
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  provider     = google
  workload_identity_pool_id = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name = "GitHub Provider"
  attribute_mapping = {
    "google.subject" = "assertion.sub"
    "attribute.actor" = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}


# Step 5: Allow GitHub Actions to impersonate the service account using Workload Identity
/*
resource "google_iam_workload_identity_pool_provider_iam_member" "allow_github_impersonation" {
  provider  = google
  workload_identity_pool_id = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = google_iam_workload_identity_pool_provider.github_provider.workload_identity_pool_provider_id
  role      = "roles/iam.workloadIdentityUser"
  member    = "principalSet://iam.googleapis.com/projects/${var.project_id}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/attribute.repository/${var.github_owner}/${var.github_repo}"
}
*/

# Step 5: Allow GitHub Actions to impersonate the service account using Workload Identity
/*
resource "google_iam_workload_identity_pool_iam_member" "allow_github_impersonation" {
  workload_identity_pool_id = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  role                      = "roles/iam.workloadIdentityUser"
  member                    = "principalSet://iam.googleapis.com/projects/${var.project_id}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/attribute.repository/${var.github_owner}/${var.github_repo}"
}
*/

# Step 6: Grant permission to the service account for the Workload Identity pool
resource "google_service_account_iam_binding" "allow_impersonation" {
  service_account_id = google_service_account.ci_service_account.name
  role               = "roles/iam.serviceAccountUser"
  members = [
    "principalSet://iam.googleapis.com/projects/${var.project_id}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.github_pool.workload_identity_pool_id}/attribute.repository/${var.github_owner}/${var.github_repo}"
  ]
}
