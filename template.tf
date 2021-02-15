terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.47.0"
    }
  }
}

variable "blob_rg" {
  type = string
  description = "Resource group to create blob in"
}

variable "blob_location" {
  type = string
  description = "Location to create blob in"
}

variable "blob_name" {
  type = string
  description = "Blob's name"
}

provider "azurerm" {
  features = {}
}

resource "azurerm_storage_account" "blob" {
  name                     = var.blob_name
  resource_group_name      = var.blob_rg
  location                 = var.blob_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "blob" {
  name                  = format("%s/%s",var.blob_name,"-container")
  storage_account_name  = azurerm_storage_account.blob.name
  container_access_type = "private"
}