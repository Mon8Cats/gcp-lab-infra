project_id = "win-gke-cicd"
//project_number = "650839457214"
project_region     = "us-central1"

# infra-service-account@win-gke-cicd.iam.gserviceaccount.com
#wi_sa_id = "projects/${var.project_id}/serviceAccounts/infra-service-account@win-gke-cicd.iam.gserviceaccount.com"
wi_sa_id = "infra-service-account"
#wi_sa_id = "projects/${var.project_id}/serviceAccounts/infra-service-account@${var.project_id}.iam.gserviceaccount.com"
wi_pool_id = "app-github-cicd-pool"
wi_pool_name = "app-github-cicd-pool"
wi_pool_provider_id = "app-github-provider"
#
github_repository      = "Mon8Cats/win-gke-app"
github_account         = "Mon8Cats"  # Optional if needed
github_repo_only  = "win-gke-infra"

#
environment     = "dev"
business_divsion = "AppDev"
subnet_ip_range  = "10.128.0.0/20"
pods_ip_range    = "10.1.0.0/21"
services_ip_range = "10.2.0.0/21"
master_ip_range  = "10.3.0.0/28"

network_name = "win-vpc"
subnet_name = "win-subnet"
subnet_region = "us-central1"