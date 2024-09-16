resource "azurerm_network_interface" "vm_nic" {
  name                = "publicinstance-nic"
  location            = "East US"
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
  }
}