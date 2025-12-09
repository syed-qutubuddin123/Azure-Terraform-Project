output "vm_nic_ids" {
  value = {
    for key, nic in azurerm_network_interface.my_nic :
    key => nic.id
  }
}

output "private_ips" {
  value = {
    for key, vm in azurerm_linux_virtual_machine.my_vm :
    key => vm.private_ip_address
  }
}
