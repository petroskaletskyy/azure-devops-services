terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

data "azurerm_resource_group" "rg" {
  name = "Petro_Skaletskyy"
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = "mysqlserver${random_string.suffix.result}"
  location                     = data.azurerm_resource_group.rg.location
  resource_group_name          = data.azurerm_resource_group.rg.name
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "sql_db" {
  name        = var.sql_database_name
  server_id   = azurerm_mssql_server.sql_server.id
  collation   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb = 10
  sku_name    = "S0"
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "myappserviceplan${random_string.suffix.result}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "mywebapp${random_string.suffix.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {}

  app_settings = {
    "SQL_SERVER_HOST"     = azurerm_mssql_server.sql_server.fully_qualified_domain_name
    "SQL_SERVER_DB"       = azurerm_mssql_database.sql_db.name
    "SQL_SERVER_USER"     = azurerm_mssql_server.sql_server.administrator_login
    "SQL_SERVER_PASSWORD" = azurerm_mssql_server.sql_server.administrator_login_password
  }
}

variable "sql_admin_password" {
  default   = "P@ssw0rd123!"
  sensitive = true
}

variable "sql_database_name" {
  default = "myDatabase"
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