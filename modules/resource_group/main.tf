####################################################
# Resource Group module
# Nothing complicated - just creates one resource group
####################################################

resource "azurerm_resource_group" "test_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}
