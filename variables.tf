variable "location" {
  description = "Azure region where everything will be created"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group (should start with test as per naming convention)"
  type        = string
  default     = "test-rg"
}

variable "vm_name" {
  description = "Name of the virtual machine (should start with test as per naming convention)"
  type        = string
  default     = "test-vm"
}

variable "vm_size" {
  description = "Size/SKU of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "testadmin"
}

variable "admin_password" {
  description = "Admin password for the VM (better to pass this via terraform.tfvars or env variable, not hardcoded)"
  type        = string
  sensitive   = true
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "Address prefix for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    environment = "test"
    project     = "test-azure-vm"
  }
}
