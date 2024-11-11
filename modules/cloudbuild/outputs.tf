# modules/api_enablement/outputs.tf

output "enabled_services" {
  description = "List of enabled services"
  value       = [for service in google_project_service.enable_apis : service.service]
}
