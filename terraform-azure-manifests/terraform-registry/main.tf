module "vnet" {
  source  = "Azure/vnet/azurerm" #registry.terraform.io
  version = "4.1.0"
  # insert the 3 required variables here

  resource_group_name = "virtualmachinedemo"
  vnet_location       = "East US"
  use_for_each        = true
}