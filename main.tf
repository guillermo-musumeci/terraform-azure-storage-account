# Configure the Microsoft Azure Provider
provider "azurerm" {
  version = "~>2.0"
  features {}
}

# create a resource gtoup
resource "azurerm_resource_group" "storage-rg" {
  name     = "kopicloud-rg"
  location = "West Europe"
}

# create a random string to avoid name collisions
resource "random_string" "random" {
  length = 16
  special = false
  upper   = false
  lower   = true
  number  = true
}

# create a storage account
resource "azurerm_storage_account" "storage-accont" {
  name                     = "kopicloudstorage${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.storage-rge.name
  location                 = azurerm_resource_group.storage-rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "demo"
  }
}
