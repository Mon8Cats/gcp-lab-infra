
output "bucket_name" {
  value = google_storage_bucket.terraform_backend_bucket.name
}

output "service_account_email" {
  value = google_service_account.workload_identity_sa.email
}