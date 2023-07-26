terraform {
  required_providers {
    azurerm = "~> 3.70.0"
    aro = "~> 1.12.0"
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret
}

provider "aro" {
  subscription_id = azurerm.subscription_id
}

resource "aro_cluster" "my_cluster" {
  name = var.cluster_name
  resource_group_name = var.resource_group_name
  domain = var.domain
  master_vm_size = var.master_vm_size
  worker_vm_size = var.worker_vm_size
  worker_node_count = var.worker_node_count
}

output "cluster_name" {
  value = aro_cluster.my_cluster.name
}