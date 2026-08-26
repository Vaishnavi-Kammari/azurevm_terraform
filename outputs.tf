output "resource_group_name" {
  description = "Name of the created resource group"
  value       = module.resource_group.name
}

output "vm_name" {
  description = "Name of the created virtual machine"
  value       = module.virtual_machine.vm_name
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = module.virtual_machine.public_ip_address
}
