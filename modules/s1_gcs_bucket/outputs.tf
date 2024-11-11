output "bucket_name" {
  description = "The name of the GCS bucket"
  value       = google_storage_bucket.my_bucket.name
}

output "bucket_self_link" {
  description = "The self link of the GCS bucket"
  value       = google_storage_bucket.my_bucket.self_link
}
