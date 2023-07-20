provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "subscription_a"
  subscription_id = var.subscription_a_id
  features {}
}

provider "azurerm" {
  alias           = "subscription_b"
  subscription_id = var.subscription_b_id
  features {}
}

