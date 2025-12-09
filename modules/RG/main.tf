resource "azurerm_resource_group" "my_RG" {
  name     = var.resource_group_name
  location = var.location
}
