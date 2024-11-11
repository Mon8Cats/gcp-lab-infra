#!/bin/bash

# Variables
REGION="us-central1"
CONNECTION_NAME="cicd-connection"
PROJECT_ID="win-gke-cicd"
GITHUB_USERNAME="Mon8Cats"  # Use your GitHub username
APP_INSTALLATION_ID="55957239"  # Get this from your GitHub account
SECRET_NAME="GITHUB_TOKEN_SECRET"

# Create Cloud Build GitHub connection
gcloud builds connections create github $CONNECTION_NAME \
  --region=$REGION \
  --project=$PROJECT_ID \
  --app-installation-id=$APP_INSTALLATION_ID \
  --authorizer-token-secret-version=projects/$PROJECT_ID/secrets/$SECRET_NAME/versions/1

echo "Cloud Build connection '$CONNECTION_NAME' created successfully."



# give the script execution permission
# chmod +x create_cloud_build_connection.sh

# run the script
# ./create_cloud_build_connection.sh

# how to get installion id? Setting -> applications -> google cloud build
# https://github.com/settings/installations/55957239

# enable google scret manager api

# github, settings, developer settings, persional access token
# crete gihub personal access token (PAT) 
# select following scopes
# give any name, copy,

# in gcloud
# gcloud services enable secretmanager.googleapis.com
# create a secret 
# gcloud secrets create GITHUB_TOKEN_SECRET --replication-policy="automatic"
# add token to the secret 
# echo "your-github-token //add tokenvaluehere | gcloud secrets versions add GITHUB_TOKEN_SECRET --data-file=-


#echo token_without_quotations | gcloud secrets versions add GITHUB_TOKEN_SECRET --data-file=-

# give permission to the cloud build sa account to access the secrete