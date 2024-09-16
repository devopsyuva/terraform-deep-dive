resource "azurerm_virtual_network" "vnet_demo" {
  name                = "demovirtualnetwork"
  address_space       = ["10.100.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.vm_rg.name
}