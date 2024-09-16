resource "azurerm_virtual_network" "vnet_demo" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  location            = var.region_code
  resource_group_name = azurerm_resource_group.vm_rg.name
}