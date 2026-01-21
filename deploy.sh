# #!/bin/bash

# # Configuration Variables
# UNIQUE_ID="123"
# RESOURCE_GROUP="Carlsberg-test"
# LOCATION="eastus2"
# ACR_NAME="flaskregistry$UNIQUE_ID"
# WEB_APP_NAME="flask-app-$UNIQUE_ID"
# SERVICE_PLAN="freeplan-azurewebapplocal"

# echo "Creating Resource Group..."
# az group create --name $RESOURCE_GROUP --location $LOCATION

# echo "Creating Azure Container Registry..."
# az acr create --resource-group $RESOURCE_GROUP --name $ACR_NAME --sku Basic --admin-enabled true

# echo "Building and Pushing Docker Image to ACR..."
# # This sends your local code to Azure to build the image remotely
# az acr build --registry $ACR_NAME --image flask-python-app:v1 .

# echo "Creating App Service Plan (Basic B1)..."
# # Note: Container support requires at least the B1 tier; Free (F1) does not support Docker.
# az appservice plan create --name $SERVICE_PLAN --resource-group $RESOURCE_GROUP --sku B1 --is-linux

# echo "Creating Web App for Containers..."
# az webapp create --resource-group $RESOURCE_GROUP --plan $SERVICE_PLAN --name $WEB_APP_NAME \
#   --deployment-container-image-name $ACR_NAME.azurecr.io/flask-python-app:v1

# echo "Configuring Authentication and Port..."
# ACR_USERNAME=$(az acr credential show --name $ACR_NAME --query "username" -o tsv)
# ACR_PASSWORD=$(az acr credential show --name $ACR_NAME --query "passwords[0].value" -o tsv)

# az webapp config appsettings set --resource-group $RESOURCE_GROUP --name $WEB_APP_NAME \
#   --settings DOCKER_REGISTRY_SERVER_URL="https://$ACR_NAME.azurecr.io" \
#   DOCKER_REGISTRY_SERVER_USERNAME=$ACR_USERNAME \
#   DOCKER_REGISTRY_SERVER_PASSWORD=$ACR_PASSWORD \
#   WEBSITES_PORT=80

# echo "---------------------------------------------------"
# echo "Deployment Complete!"
# echo "URL: https://$WEB_APP_NAME.azurewebsites.net"
# echo "---------------------------------------------------"