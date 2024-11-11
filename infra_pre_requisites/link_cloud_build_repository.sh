#!/bin/bash

# Variables
REGION="us-central1"
CONNECTION_NAME="cicd-connection"
PROJECT_ID="win-gke-cicd"

REPOSITORY_NAME_1="win-gke-infra"
REMOTE_URI_1="https://github.com/Mon8Cats/win-gke-infra.git"

REPOSITORY_NAME_2="win-gke-app"
REMOTE_URI_2="https://github.com/Mon8Cats/win-gke-app.git"

# Link Repository 1
gcloud builds repositories create $REPOSITORY_NAME_1 \
  --connection=$CONNECTION_NAME \
  --region=$REGION \
  --remote-uri=$REMOTE_URI_1 \
  --project=$PROJECT_ID

echo "Repository '$REPOSITORY_NAME_1' linked successfully in Cloud Build."

# Link Repository 2
gcloud builds repositories create $REPOSITORY_NAME_2 \
  --connection=$CONNECTION_NAME \
  --region=$REGION \
  --remote-uri=$REMOTE_URI_2 \
  --project=$PROJECT_ID

echo "Repository '$REPOSITORY_NAME_2' linked successfully in Cloud Build."


# gcloud alpha builds repositories list --region=us-central1


# give the script execution permission
# chmod +x link_cloud_build_repository.sh

# run the script
# ./link_cloud_build_repository.sh


# gcloud builds repositories list --region=global --project=win-gke-cicd