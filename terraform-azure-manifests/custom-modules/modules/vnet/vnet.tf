resource "azurerm_virtual_network" "vnet_demo" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  resource_group_name = azurerm_resource_group.vnet_demo_rg.name
  location            = var.region
}