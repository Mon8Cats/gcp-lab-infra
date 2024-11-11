
# (1) enable apis
module "enable_apis" {
  source     = "../modules/s2_enable_apis"
  project_id = var.project_id
  api_services = var.api_list
}


# (2) create a service account for CICD

module "my_service_account" {
  source               = "../modules/s3_service_account"
  project_id           = var.project_id
  service_account_name = var.cicd_sa_name
  display_name         = "My Terraform Service Account"
  description          = "This service account is used for CI/CD operations"

  roles = var.cicd_sa_role_list
}

# (3) create workload identity pool
module "workloadidentity" {
  source           = "../modules/s4_workload_identity"
  project_id = var.project_id
  wi_pool_id = var.wi_pool_id
  wi_pool_name = var.wi_pool_name
  wi_pool_provider_id = var.wi_pool_provider_id
  github_repository = var.github_repository
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.cicd_sa_name}@${var.project_id}.iam.gserviceaccount.com"
}
