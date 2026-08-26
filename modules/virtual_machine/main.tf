####################################################
# Virtual Machine module
# Creates the basic networking a VM needs (vnet, subnet,
# public ip, nic, nsg) and then the VM itself.
# Kept as simple as possible - one VM, one NIC, one disk.
####################################################

resource "azurerm_virtual_network" "test_vnet" {
  name                = "test-vnet"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "test_subnet" {
  name                 = "test-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.test_vnet.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_public_ip" "test_public_ip" {
  name                = "test-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_network_security_group" "test_nsg" {
  name                = "test-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "allow-ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "test_nic" {
  name                = "test-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "test-ipconfig"
    subnet_id                     = azurerm_subnet.test_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.test_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "test_nic_nsg" {
  network_interface_id      = azurerm_network_interface.test_nic.id
  network_security_group_id = azurerm_network_security_group.test_nsg.id
}

resource "azurerm_linux_virtual_machine" "test_vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  # password auth is fine for a "test" setup, but for real
  # production workloads switch this to SSH keys instead
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.test_nic.id
  ]

  os_disk {
    name                 = "test-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}
