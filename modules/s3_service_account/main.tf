
# Create the Google Cloud Service Account
resource "google_service_account" "my_sa" {
  project      = var.project_id
  account_id   = var.service_account_name
  display_name = var.display_name
  description  = var.description
}

# Assign IAM roles to the Service Account
resource "google_project_iam_member" "my_sa_roles" {
  for_each = toset(var.roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.my_sa.email}"
}
