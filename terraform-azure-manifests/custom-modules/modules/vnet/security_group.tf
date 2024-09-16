resource "azurerm_network_security_group" "example" {
  name                = "WebserverTrafficControl"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet_demo_rg.name

  security_rule {
    name                       = "webtraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}