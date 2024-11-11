# Main GKE Cluster resource
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  project            = var.project_id
  network            = var.network
  initial_node_count = 1  # Disable the default node pool

  remove_default_node_pool = true
  node_locations           = var.node_locations

  ip_allocation_policy {}
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

# Node pools in different subnets
resource "google_container_node_pool" "node_pools" {
  count      = length(var.node_pools)
  cluster    = google_container_cluster.primary.name
  location   = var.region
  project    = var.project_id
  name       = "${var.cluster_name}-node-pool-${count.index}"
  node_count = var.node_pools[count.index].node_count

  node_config {
    machine_type = var.node_pools[count.index].machine_type
    #subnetwork   = var.node_pools[count.index].subnetwork
    tags         = var.node_pools[count.index].node_tags

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

  }

  autoscaling {
    min_node_count = var.node_pools[count.index].min_node_count
    max_node_count = var.node_pools[count.index].max_node_count
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}
