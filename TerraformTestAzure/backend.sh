backend "azurerm" {
    resource_group_name   = "nick-dev-terraform-backend-rg"
    storage_account_name  = "nicdevterraformbackendsa"
    container_name        = "nick-terraform-backend-files"
    key                   =  "**************"
}
