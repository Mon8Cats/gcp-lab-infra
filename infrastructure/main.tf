
# enable apis
module "enable_apis" {
  source     = "../modules/s2_enable_apis"
  project_id = var.project_id
  api_services = var.api_list
}


# create a service account for CICD


module "my_service_account" {
  source               = "../modules/s3_service_account"
  project_id           = var.project_id
  service_account_name = "cicd-sa"
  display_name         = "My Terraform Service Account"
  description          = "This service account is used for CI/CD operations"

  roles = var.cicd_sa_role_list
}
