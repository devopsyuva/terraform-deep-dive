resource "azurerm_network_interface" "vm_nic" {
  name                = var.nic_name
  location            = var.region_code
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }

  tags = merge(
    {
      "Name" = var.nic_name
    },
    local.common_tags
  )
}