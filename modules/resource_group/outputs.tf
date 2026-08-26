output "name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.test_rg.name
}

output "location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.test_rg.location
}

output "id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.test_rg.id
}
