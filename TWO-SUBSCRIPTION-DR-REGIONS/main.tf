# Create resource groups in the primary region of subscription A
resource "azurerm_resource_group" "primary_resource_groups_subscription_a" {
  count    = var.resource_group_count
  name     = element(var.resource_group_names_subscription_a, count.index)
  location = var.primary_region
}

# Create resource groups in the DR region of subscription A
resource "azurerm_resource_group" "dr_resource_groups_subscription_a" {
  count    = var.resource_group_count
  name     = "dr-${element(var.resource_group_names_subscription_a, count.index)}"
  location = var.dr_region
}

# Create resource groups in the primary region of subscription B
resource "azurerm_resource_group" "primary_resource_groups_subscription_b" {
  count    = var.resource_group_count
  name     = element(var.resource_group_names_subscription_b, count.index)
  location = var.primary_region
}

# Create resource groups in the DR region of subscription B
resource "azurerm_resource_group" "dr_resource_groups_subscription_b" {
  count    = var.resource_group_count
  name     = "dr-${element(var.resource_group_names_subscription_b, count.index)}"
  location = var.dr_region
}

