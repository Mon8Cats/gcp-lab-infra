output "wi_pool_id" {
  description = "The ID of Workload Identity Pool"
  value       = google_iam_workload_identity_pool.github_pool.id
}

output "wi_pool_provider_id" {
  description = "The ID of Workload Identity Pool Provider"
  value       = google_iam_workload_identity_pool_provider.github_provider.id
}
