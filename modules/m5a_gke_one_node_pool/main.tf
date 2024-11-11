# Create the GKE Cluster
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  project            = var.project_id
  network            = var.network
  subnetwork         = var.subnetwork
  initial_node_count = 1  # Initial node count for the default pool, if used

  remove_default_node_pool = true  # Remove the default node pool
  node_locations           = var.node_locations

  # Enable basic services
  ip_allocation_policy {}
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.master_authorized_network
      display_name = "Home IP Range"
    }
  }

  # Enable logging and monitoring
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

# Create a node pool with specified configurations
resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = var.region
  project    = var.project_id
  name       = "${var.cluster_name}-node-pool"
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    preemptible  = var.preemptible

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    tags = var.node_tags
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}
