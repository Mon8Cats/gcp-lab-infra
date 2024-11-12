resource "google_cloudbuild_trigger" "github_trigger" {
  name         = var.trigger_name
  description  = "Trigger for GitHub repository"
  region       = var.region
  
  github {
    owner        = var.github_owner
    name         = var.repo_name
    push {
      branch = var.branch_pattern
    }
  }
  build {
    filename = var.build_config
  }
  service_account = var.service_account_email
}

output "trigger_id" {
  value = google_cloudbuild_trigger.github_trigger.id
}
