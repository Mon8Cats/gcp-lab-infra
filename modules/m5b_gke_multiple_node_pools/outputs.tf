output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary.name
}

output "endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = google_container_cluster.primary.endpoint
}

output "master_version" {
  description = "The Kubernetes master version of the GKE cluster."
  value       = google_container_cluster.primary.master_version
}

output "node_pool_id" {
  description = "The ID of the GKE node pool."
  value       = google_container_node_pool.primary_nodes.id
}
