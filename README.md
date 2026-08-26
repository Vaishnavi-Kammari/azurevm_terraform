# Terraform Azure VM Setup

Simple, modularized Terraform project that creates:

1. A **Resource Group**
2. A **Virtual Machine** (Linux/Ubuntu) along with the basic networking it needs
   (virtual network, subnet, public IP, network security group, network interface)


## Naming convention

- `test-rg` – resource group
- `test-vm` – virtual machine
- `test-vnet` – virtual network
- `test-subnet` – subnet
- `test-nic` – network interface
- `test-nsg` – network security group
- `test-public-ip` – public IP
- `test-osdisk` – OS disk

You can change these defaults any time in `terraform.tfvars`.

## Folder structure

```
terraform-azure-vm/
├── main.tf                     # Root module, wires everything together
├── variables.tf                 # Root level input variables
├── outputs.tf                   # Root level outputs
├── providers.tf                  # Azure provider configuration
├── terraform.tfvars.example      # Sample variable values (copy to terraform.tfvars)
├── README.md                     # You're reading it
└── modules/
    ├── resource_group/
    │   ├── main.tf                # Creates the resource group
    │   ├── variables.tf
    │   └── outputs.tf
    └── virtual_machine/
        ├── main.tf                # Creates VM + networking
        ├── variables.tf
        └── outputs.tf
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.3.0
- An Azure subscription
- Azure CLI installed and logged in (`az login`), so Terraform can authenticate

## How to use it

1. Update it with your own values:

   ```bash
   terraform.tfvars
   ```

   At minimum, set a strong `admin_password`.

2. Log in to Azure:

   ```bash
   az login
   ```

3. Initialize Terraform (downloads the azurerm provider):

   ```bash
   terraform init
   ```

4. See what will be created:

   ```bash
   terraform plan
   ```

5. Apply it:

   ```bash
   terraform apply
   ```

6. When you're done testing, clean up so you don't get billed for idle resources:

   ```bash
   terraform destroy
   ```

## Outputs

After `terraform apply` finishes, you'll see:

- `resource_group_name` – the name of the created resource group
- `vm_name` – the name of the created VM
- `vm_public_ip` – the public IP you can use to SSH into the VM

Example:

```bash
ssh testadmin@<vm_public_ip>
```

## Notes

- The VM uses **password authentication** by default to keep things simple for testing.
  For anything beyond testing, switch to SSH key authentication instead
  (set `disable_password_authentication = true` and add an `admin_ssh_key` block
  in `modules/virtual_machine/main.tf`).
- Default VM size is `Standard_B1s` (small and cheap) — bump this up in
  `terraform.tfvars` if you need more power.
- Default image is Ubuntu 22.04 LTS. Change `source_image_reference` in
  `modules/virtual_machine/main.tf` if you want a different OS.
- `terraform.tfvars` is intentionally left out of version control (see `.gitignore`)
  since it can contain your password — don't commit it.
