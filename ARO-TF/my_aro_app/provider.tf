# provider.tf

# AzureRM provider for managing the ARO cluster
provider "azurerm" {
  features {}
  # Add your Azure subscription ID here
  subscription_id = "YOUR_AZURE_SUBSCRIPTION_ID"
  # Add your desired version of the AzureRM provider
  version = "=2.0.0"
  # Configure the AzureRM provider to use a service principal for authentication
  # Update these values with your service principal details
  client_id       = "YOUR_SERVICE_PRINCIPAL_CLIENT_ID"
  client_secret   = "YOUR_SERVICE_PRINCIPAL_CLIENT_SECRET"
  tenant_id       = "YOUR_AZURE_TENANT_ID"
}

# Kubernetes provider for deploying applications to the ARO cluster
provider "kubernetes" {
  # Set the ARO cluster's kubeconfig file path
  kubeconfig = file("${path.module}/kubeconfig_my_aro_app")
}
