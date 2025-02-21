terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "PetroSkaletskyy-resources"
  location = "North Europe"
}

resource "azurerm_storage_account" "storage" {
  name                     = "terraformstatesa${random_string.unique.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"
}

resource "azurerm_storage_container" "containers" {
  count                 = 3
  name                  = "terraform-state-${count.index + 1}"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}