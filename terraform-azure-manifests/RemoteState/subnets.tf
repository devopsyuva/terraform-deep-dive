resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet_one
  resource_group_name  = "virtualmachinedemo"
  virtual_network_name = azurerm_virtual_network.vnet_demo.name
  address_prefixes     = ["10.100.0.0/24"]
}

resource "azurerm_subnet" "subnet02" {
  name                 = var.subnet_two
  resource_group_name  = "virtualmachinedemo"
  virtual_network_name = azurerm_virtual_network.vnet_demo.name
  address_prefixes     = ["10.100.2.0/24"]
}