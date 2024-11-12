# Cloud Build Trigger

## Step 1: Create GitHub Personal Access Token

Your Account> Settings> Developer Settings> Personal access tokens>
    Fine-grained tokens or Classic Tokens
    I choose Classic Token

1. Go to your GitHub account and create a Personal Access Token (PAT) with the following scopes:
    - repo (for full access to your repositories)
    - workflow (if you are using GitHub Actions)
2. Copy the token as it will be used in the next step.

## Step 2: Store the GitHub Token in GCP Secret Manager

1. Open GCP Console or use the gcloud CLI.

2. Create a secret in Secret Manager to securely store the GitHub token:
   
```bash
echo "YOUR_GITHUB_TOKEN" | gcloud secrets create github-token --replication-policy="automatic" --data-file=-
```

3. Grant the Cloud Build service account access to read this secret:

```bash
PROJECT_NUMBER=$(gcloud projects describe YOUR_PROJECT_ID --format="value(projectNumber)")
gcloud secrets add-iam-policy-binding github-token \
    --member="serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com" \
    --role="roles/secretmanager.secretAccessor"
```


## Step 3: Create a GitHub Connection in Cloud Build

1. Create a GitHub connection using the GCP Console or via gcloud CLI. Here is the CLI command:

```bash
gcloud beta builds connections create github cicd-connection \
    --region=us-central1 \
    --secret="github-token"

```
    - Replace cicd-connection with your desired connection name.
    - Ensure the region matches where you want the connection created.

## Step 4: Link Your GitHub Repository

1. Link your GitHub repository to the connection:
```bash
gcloud beta builds repositories create \
    --connection="cicd-connection" \
    --region="us-central1" \
    --repository="your-github-repo-name" \
    --owner="your-github-username"

```

## Step 5: Create a Cloud Build Trigger

1. You can create a Cloud Build trigger using the GCP Console or via Terraform/gcloud CLI.

Example using gcloud:
```bash
gcloud beta builds triggers create github \
    --name="build-trigger" \
    --region="us-central1" \
    --repository="your-github-repo-name" \
    --branch-pattern="^main$" \
    --build-config="cloudbuild.yaml"

```

## Notes:

- You can also configure the trigger using Terraform, which you've already been doing. Make sure the connection is created and the repository is linked before setting up the trigger in Terraform.
- You need the gcloud beta commands for creating connections and linking repositories because this feature is still in the beta stage.