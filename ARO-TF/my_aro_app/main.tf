# main.tf

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aro_app_rg" {
  name     = "my-aro-app-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aro_app_cluster" {
  name                = "my-aro-app-cluster"
  resource_group_name = azurerm_resource_group.aro_app_rg.name
  location            = azurerm_resource_group.aro_app_rg.location
  dns_prefix          = "my-aro-app-cluster-dns"
  kubernetes_version  = "1.20.7"
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aro_app_cluster.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aro_app_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aro_app_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aro_app_cluster.kube_config.0.cluster_ca_certificate)
}

# main.tf

resource "null_resource" "apply_k8s_manifests" {
  provisioner "local-exec" {
    command = "kubectl apply -f kubernetes/"
    interpreter = ["bash", "-c"]
  }
  depends_on = [azurerm_kubernetes_cluster.aro_app_cluster]
}
