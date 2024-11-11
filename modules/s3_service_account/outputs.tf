
output "service_account_email" {
  description = "The email address of the service account"
  value       = google_service_account.my_sa.email
}

output "service_account_id" {
  description = "The unique ID of the service account"
  value       = google_service_account.my_sa.unique_id
}

