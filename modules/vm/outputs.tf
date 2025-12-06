output "vm_nic_ids" {
  value = { for k, v in azurerm_network_interface.my_nic : k => v.id }
}
