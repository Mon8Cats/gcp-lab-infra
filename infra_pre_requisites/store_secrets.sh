
#echo -n "my_db_user" | gcloud secrets create db_user --data-file=-
#echo -n "my_db_password" | gcloud secrets create db_password --data-file=-


# verify api enablement
# gcloud services list --enabled | grep secretmanager


# list secrets
# gcloud secrets list
