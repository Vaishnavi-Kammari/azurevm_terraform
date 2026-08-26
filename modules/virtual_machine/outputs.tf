output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.test_vm.name
}

output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.test_vm.id
}

output "public_ip_address" {
  description = "Public IP address of the VM (check after apply, it can take a moment to show)"
  value       = azurerm_public_ip.test_public_ip.ip_address
}

output "private_ip_address" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.test_nic.private_ip_address
}
