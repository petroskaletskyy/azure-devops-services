terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "PetroSkaletskyy-resources"
    storage_account_name = "terraformstatesa0gyq9t"
    container_name       = "tfstate"
    key                  = "terraform.tfstate" 
  }
}

  variable "subscription_id" {
  description = "Azure subscription ID"
  type = string
  sensitive = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type = string
  sensitive = true
}

variable "client_id" {
  description = "Azure service principal client ID"
  type = string
  sensitive = true
}

variable "client_secret" {
  description = "Azure serviceprincipal client secret"
  type = string
  sensitive = true
}

variable "storageAccountName" {
  description = "Storage account name for backend"
  default = "terraformstatesa0gyq9t"
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
}

data "azurerm_resource_group" "rg" {
  name     = "Petro_Skaletskyy"
}

resource "azurerm_virtual_network" "vnet" {
  name = "test-vnet"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  address_space = [ "10.0.0.0/16" ]
}