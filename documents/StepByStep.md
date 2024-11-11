## Create Backend bucket 

Cope Git Repo into the Cloud Shell
Run the terraform config files.

Error:
```bash
Your version of Terraform is out of date! The latest version
is 1.9.8. 
```

1. Install tfenv
```bash
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

```

2. Install the Latest Terraform Version:

```bash
tfenv install latest

```

3. Set the Latest Version as Default:
```bash
tfenv use latest
```

4. Verify the Installation:

```bash
terraform version
```

The billing account for your GCP project is disabled. Without an active billing account, you cannot create or manage Google Cloud resources like storage buckets.

Go to the Billing
This project has no billing account
Click "Link A Billing Account"


List GCS Buckets
```bash
gcloud alpha storage buckets list
gcloud beta storage buckets list
gsutil ls
gcloud alpha storage buckets list --project=<your-project-id>
gsutil ls -p <your-project-id>

```

I cannot see the bucket
```bash
gcloud config list
gcloud config set project <your-project-id>

```

Set Environment Variables
```bash
export PROJECT_ID=$(gcloud config get-value project)
export REGION="us-central1"

echo $PROJECT_ID
echo $REGION

```

Use environment variable in `teffaform.tfvars`
```bash
project_id = "${env.PROJECT_ID}"
region     = "${env.REGION}"

```


It is not working. Use the following, end exclude setting form tfvars.

```bash
export TF_VAR_project_id=$(gcloud config get-value project)
export TF_VAR_region="us-central1"
echo $TF_VAR_project_id
echo $TF_VAR_region

```

Add `cloudresourcemanager.googleapis.com`,  # Add this API first


## What Does "Tainted" Mean?

A tainted resource in Terraform is one that has been marked for re-creation. This usually happens when:

1. The resource is in an inconsistent state.
2. There was a failure during its creation or update.
3. You explicitly tainted it using the terraform taint command.
   
In your case, it seems like the API enablement process for compute.googleapis.com (Compute Engine API) did not complete successfully, or there was an issue during the previous terraform apply.

### Solution Steps

#### Option 1: Manually Re-Run terraform apply

Since Terraform is already planning to replace the tainted resource, you can proceed with:

```bash
terraform apply
```

This will attempt to re-enable the Compute Engine API (compute.googleapis.com).

#### Option 2: Explicitly Untaint the Resource

If you want to try to fix the issue without re-creating the resource, you can untaint it manually:

```bash
terraform untaint module.enable_apis.google_project_service.enabled_apis["compute.googleapis.com"]
```
Then re-run:

```bash
terraform apply
```

#### Option 3: Force Re-Create the Resource

If the above steps do not work, you can force Terraform to destroy and then re-create the resource:

```bash
terraform destroy -target=module.enable_apis.google_project_service.enabled_apis["compute.googleapis.com"]
terraform apply
```

#### Option 4: Check API Status in GCP Console

Sometimes, the API may already be enabled in the Google Cloud Console, but Terraform is not aware of it. To verify:

1. Go to the Google Cloud API Library in your GCP project.
2. Search for Compute Engine API (compute.googleapis.com) and check if it is already enabled.
3. If it is enabled, you can skip this resource from being managed by Terraform by removing it from your api_services list temporarily.


### Troubleshooting Tips

- **Ensure Permissions**: The service account running Terraform must have roles/serviceusage.serviceUsageAdmin or similar permissions to enable APIs.
- **Check API Quotas**: You may be hitting a quota limit for enabling APIs. You can view API quotas and usage from the API Quotas Page.


## List enabled apis

```bash
gcloud services list --enabled
gcloud services list --available
gcloud services disable <api-name>
gcloud services disable compute.googleapis.com
gcloud services list --enabled --project=<your-project-id>

```


## Create service account 

To check the roles assigned to a service account using gcloud, you can use the following commands:

```bash
gcloud iam service-accounts get-iam-policy cicd-sa@my-project.iam.gserviceaccount.com
gcloud projects get-iam-policy [PROJECT_ID] --filter="bindings.members:[SERVICE_ACCOUNT_EMAIL]"
gcloud projects get-iam-policy my-project-id --filter="bindings.members:cicd-sa@my-project.iam.gserviceaccount.com"
gcloud iam roles describe [ROLE_NAME]

$ gcloud projects get-iam-policy mon8cats-cloud-lab \
    --filter="bindings.members:serviceAccount:cicd-sa@mon8cats-cloud-lab.iam.gserviceaccount.com" \
    --format="json"

```

## Understanding the Difference:

- **Project-Level IAM Bindings**: These are roles assigned at the project level using google_project_iam_member or google_project_iam_binding. This is what you’re seeing in the output from gcloud projects get-iam-policy.
- **Service Account IAM Policy**: This would show roles assigned directly to the service account resource, typically done using google_service_account_iam_member or google_service_account_iam_binding.