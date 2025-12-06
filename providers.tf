terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-RG"
    storage_account_name = "farhanstatestorage123"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "b15d17f1-c2bf-4d36-a55c-66257ccfb836"
}
