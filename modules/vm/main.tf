resource "azurerm_network_interface" "my_nic" {
  for_each            = var.servers
  name                = "my_nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "my_vm" {
  for_each            = var.servers
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value

  admin_username      = "syedazure"
  admin_password      = "Password@123"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.my_nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
