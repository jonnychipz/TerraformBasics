# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  backend "azurerm" {
    resource_group_name   = "jonnychipz-state"
    storage_account_name  = "jonnychipztfstate"
    container_name        = "tstate"
    key                   = "iothub.tfstate"
    }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "myrg" {
  name     = "jonnychipz-iothub-rg"
  location = var.primary_location
}

# Create an IOTHub
resource "azurerm_iothub" "myIoTHub" {
  name                = "Test-IoTHub"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location

  sku {
    name     = "S1"
    capacity = "1"
  }
}