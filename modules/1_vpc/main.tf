# main.tf

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create VPC network
resource "google_compute_network" "custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks  = false  # Custom subnet mode
  routing_mode             = "REGIONAL"
}

# Create Subnet
resource "google_compute_subnetwork" "custom_subnet" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_cidr  # Use the CIDR range from variable
  region                   = var.region
  network                  = google_compute_network.custom_vpc.id
}
