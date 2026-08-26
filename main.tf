####################################################
# Root main.tf
# Just wires up the two modules - resource group first,
# then the VM (and its networking) inside that group
####################################################

module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "virtual_machine" {
  source = "./modules/virtual_machine"

  vm_name               = var.vm_name
  vm_size               = var.vm_size
  location              = module.resource_group.location
  resource_group_name   = module.resource_group.name
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  vnet_address_space    = var.vnet_address_space
  subnet_address_prefix = var.subnet_address_prefix
  tags                  = var.tags

  # make sure resource group is fully created before the VM stuff starts
  depends_on = [module.resource_group]
}
