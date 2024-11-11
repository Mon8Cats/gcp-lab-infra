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