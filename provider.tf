terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.10.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "5f45be49-91c7-4b3d-9055-dbb5e3a79364"
  use_cli = true
}