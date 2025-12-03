resource "azurerm_resource_group" "my_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.my_rg.name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "my_subnet1"
  resource_group_name  = azurerm_resource_group.my_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "vm" {
  source              = "./modules/vm"
  servers             = var.servers
  location            = var.location
  resource_group_name = azurerm_resource_group.my_rg.name
  subnet_id           = azurerm_subnet.subnet.id
}

