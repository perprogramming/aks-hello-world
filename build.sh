#!/bin/bash

# Fail on any error
set -e

# Define variables
export AZURE_SERVICE_PRINCIPAL_ID=$AZURE_CLI_ID
export AZURE_SERVICE_PRINCIPAL_SECRET=$AZURE_CLI_KEY
export AZURE_TENANT="infoperprogramming.onmicrosoft.com"
export APP_NAME="aks-hello-world"

# Login to Azure using a service principal
az login \
    --service-principal \
    -u $AZURE_SERVICE_PRINCIPAL_ID \
    -p $AZURE_SERVICE_PRINCIPAL_SECRET \
    --tenant $AZURE_TENANT

# Create a new resource group for the app
az group create \
    --name $APP_NAME \
    --location westeurope

# Create a new kubernetes cluster for the app
az aks create \
  --service-principal $AZURE_SERVICE_PRINCIPAL_ID \
  --client-secret $AZURE_SERVICE_PRINCIPAL_SECRET \
  --resource-group $APP_NAME \
  --name $APP_NAME \
  --node-count 1 \
  --enable-addons monitoring \
  --generate-ssh-keys

# Download kubernetes config for the newly created cluster
az aks get-credentials \
    --resource-group $APP_NAME \
    --name $APP_NAME

# Install kubectl
az aks install-cli

# Deploy app
kubectl apply -f kubernetes-manifest.yml

# Wait for loadbalancer to display details e.g. external IP
while (kubectl get svc azure-vote-front | grep pending); do sleep 10; done
kubectl describe svc azure-vote-front

