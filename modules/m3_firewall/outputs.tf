output "firewall_rule_id" {
  description = "The ID of the firewall rule."
  value       = google_compute_firewall.firewall_rule.id
}

output "firewall_rule_name" {
  description = "The name of the firewall rule."
  value       = google_compute_firewall.firewall_rule.name
}
