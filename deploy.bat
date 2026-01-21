@echo off
:: CHANGE THIS VALUE to something unique to you (lowercase letters and numbers only)
set UNIQUE_ID=kjadhav777
set RESOURCE_GROUP=Carlsberg-test
set LOCATION=eastus2
set ACR_NAME=flaskregistry%UNIQUE_ID%
set WEB_APP_NAME=flask-app-%UNIQUE_ID%
set SERVICE_PLAN=freeplan-azurewebapplocal

echo.
echo === Step 1: Check/Create Container Registry ===
:: Check if the ACR exists in your subscription
call az acr show --name %ACR_NAME% --resource-group %RESOURCE_GROUP% >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Registry %ACR_NAME% not found. Attempting to create...
    call az acr create --resource-group %RESOURCE_GROUP% --name %ACR_NAME% --sku Basic --admin-enabled true
) else (
    echo Registry %ACR_NAME% found.
)

:: Re-verify if creation was successful
call az acr show --name %ACR_NAME% --resource-group %RESOURCE_GROUP% >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: The name '%ACR_NAME%' is already taken by someone else in Azure.
    echo Please edit deploy.bat and change UNIQUE_ID to a different value.
    pause
    exit /b
)

echo.
echo === Step 2: Build Image in the Cloud ===
call az acr build --registry %ACR_NAME% --image flask-python-app:v1 .

echo.
echo === Step 3: Deploy to Web App ===
call az webapp create --resource-group %RESOURCE_GROUP% --plan %SERVICE_PLAN% --name %WEB_APP_NAME% --deployment-container-image-name %ACR_NAME%.azurecr.io/flask-python-app:v1

echo.
echo === Step 4: Configure Port and Credentials ===
for /f "tokens=*" %%a in ('az acr credential show --name %ACR_NAME% --query "username" -o tsv') do set ACR_USERNAME=%%a
for /f "tokens=*" %%a in ('az acr credential show --name %ACR_NAME% --query "passwords[0].value" -o tsv') do set ACR_PASSWORD=%%a

call az webapp config appsettings set --resource-group %RESOURCE_GROUP% --name %WEB_APP_NAME% --settings DOCKER_REGISTRY_SERVER_URL=https://%ACR_NAME%.azurecr.io DOCKER_REGISTRY_SERVER_USERNAME=%ACR_USERNAME% DOCKER_REGISTRY_SERVER_PASSWORD=%ACR_PASSWORD% WEBSITES_PORT=80

echo.
echo ===================================================
echo SUCCESS! Visit: https://%WEB_APP_NAME%.azurewebsites.net
echo ===================================================
