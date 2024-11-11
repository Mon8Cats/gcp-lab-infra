resource "google_compute_firewall" "firewall_rule" {
  name    = var.rule_name
  project = var.project_id
  network = var.network

  # Define the direction of traffic: either INGRESS or EGRESS
  direction = var.direction

  # Priority of the rule (lower number is higher priority)
  priority = var.priority

  # Define allowed protocols and ports
  allow {
    protocol = var.allow_protocol
    ports    = var.allow_ports
  }

  # Define the source or target ranges based on direction
  source_ranges = var.direction == "INGRESS" ? var.source_ranges : null
  destination_ranges = var.direction == "EGRESS" ? var.destination_ranges : null

  # Optional - target tags for VM instances
  target_tags = var.target_tags
}
