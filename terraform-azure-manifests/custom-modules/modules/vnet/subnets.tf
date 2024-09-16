resource "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  resource_group_name  = azurerm_resource_group.vnet_demo_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_demo.name
  address_prefixes     = var.subnet01
}

resource "azurerm_subnet" "subnet02" {
  name                 = "subnet02"
  resource_group_name  = azurerm_resource_group.vnet_demo_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_demo.name
  address_prefixes     = var.subnet02
}