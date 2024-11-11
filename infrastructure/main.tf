
# enable apis
module "enable_apis" {
  source     = "../modules/s2_enable_apis"
  project_id = var.project_id
  api_services = var.api_list
}