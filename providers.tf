terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.54.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "b15d17f1-c2bf-4d36-a55c-66257ccfb836"
}
