# Grant the custom service account access to read the GitHub token secret
resource "google_secret_manager_secret_iam_member" "github_token_access" {
  secret_id = var.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account_email}"
}
