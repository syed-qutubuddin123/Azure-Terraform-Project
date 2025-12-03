output "vm_ids" {
  value = { for k, v in azurerm_linux_virtual_machine.my_vm : k => v.id }
}
