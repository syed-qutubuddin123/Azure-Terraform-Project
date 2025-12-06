resource "azurerm_public_ip" "lb_ip" {
  name                = "${var.environment}-lb-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "my_lb" {
  name                = "${var.environment}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  name            = "backendpool"
  loadbalancer_id = azurerm_lb.my_lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_attach" {
  for_each                = var.vm_nic_ids
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
  network_interface_id     = each.value
  ip_configuration_name    = "internal"
}
