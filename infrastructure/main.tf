/* No space around =
export TF_VAR_project_id="mon8cats-cloud-lab"
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_region
*/

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

# (4) Create Cloud Build Trigger
# (4.a) Create Github Personal Access Token (in GitHub)
# (4.b) Store the GitHub Token in GCP Secret Manager (in Cloud Shell)
# glcoud secrets list

# (4.c) Grant the Service Account access to read this secret
# (4.d) Create a GitHub Connection in Cloud Build
# (4.e) Link my GitHub Repository
# (4.f) Create a Cloud Build Trigger

module "secret_access" {
  source               = "../modules/s5_secret_access"
  secret_id = var.github_token_secret_id
  service_account_email = local.cicd_service_account_email
}


# in cloud shell
module "secret_access2" {
  source               = "../modules/s5_secret_access"
  secret_id = var.github_token_secret_id
  service_account_email = "service-1087970471800@gcp-sa-cloudbuild.iam.gserviceaccount.com"
  # what is this account?
}


# Call the Secret Manager module for `db_username`
module "secret_manager_db_user" {
  source       = "../modules/z2_secret_manager"
  project_id = var.project_id
  #secret_name  = "db-username"
  secret_id = "db-user"
  secret_data = var.db_username
}

module "secret_manager_db_password" {
  source       = "../modules/z2_secret_manager"
  project_id = var.project_id
  #secret_name  = "db-password"
  secret_id = "db-password"
  secret_data = var.db_password
}


data "google_secret_manager_secret_version" "db_username" {
  secret  = module.secret_manager_db_user.secret_id
  version = "latest"
}

data "google_secret_manager_secret_version" "db_password" {
  secret  = module.secret_manager_db_password.secret_id
  version = "latest"
}

module "cloud_sql" {
  source        = "../modules/z3_cloud_sql_postgres"
  db_instance_name = var.db_instance_name
  region        = var.region
  db_machine_type  = var.db_machine_type
  db_username   = base64decode(data.google_secret_manager_secret_version.db_username.secret_data)
  db_password   = base64decode(data.google_secret_manager_secret_version.db_password.secret_data)
}



# check 
#  gcloud secrets get-iam-policy <secret-name> --project=<project id>
#  terraform init -upgrade

# installation id -> github > settings > application > Google Cloud Build > click configure > check url

/*
module "github_connection" {
  source    = "../modules/s6_github_connection"
  providers = {
    google-beta = google-beta.beta
  }

  project_id                = var.project_id
  connection_name           = "cicd-connection"
  region                    = var.region
  github_app_installation_id = var.github_app_installation_id
  github_token_secret       = var.github_token_secret_id

  # Implicit dependency using the output value from secret_access2
  secret_access_status = module.secret_access2.secret_access_status
}
*/