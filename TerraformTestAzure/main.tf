terraform {
  backend "azurerm" {
    resource_group_name  = "nick-dev-terraform-backend-rg"
    storage_account_name = "nicdevterraformbackendsa"
    container_name       = "nick-terraform-backend-files"
    key                  = "***********"
  }

  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 2.7.0"
    }
  }
}
provider "azurerm" {
  version = ">= 2.7.0"
  features {}
  skip_provider_registration = true
}

data "azurerm_client_config" "current" {}
# Create our Resource Group 
resource "azurerm_resource_group" "rg" {
  name     = "nicholasg-app01"
  location = "northeurope"
}
# Create our Virtual Network 
resource "azurerm_virtual_network" "vnet" {
  name                = "nicholasvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# Create our Subnet to hold our VM - Virtual Machines
resource "azurerm_subnet" "sn" {
  name                 = "VM"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
# Create our Azure Storage Account 
resource "azurerm_storage_account" "nicholasgzsa" {
  name                     = "nicholasgzsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "nicholasenv1"
  }
}
# Create our vNIC for our VM and assign it to our Virtual Machines Subnet
resource "azurerm_network_interface" "vmnic" {
  name                = "nicholasvm01nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
  }
}
# Create our Virtual Machine - VM01
resource "azurerm_virtual_machine" "nicholasvm01" {
  name                  = "nicholasvm01"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = "Standard_B2s"
  depends_on = [azurerm_network_interface.vmnic]
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core-smalldisk"
    version   = "latest"
  }
  storage_os_disk {
    name              = "nicholasvm01os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "nicholasvm01"
    admin_username = "nicholasadmin"
    admin_password = "Password123$"
  }
  os_profile_windows_config {
  }
}
