resource "azurerm_network_interface" "vm_nic" {
  count               = var.count_number
  name                = "var.nic_name-${count.index}"
  location            = var.region_code
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.vm_public_ip.*.id, count.index)
  }

  depends_on = [azurerm_public_ip.vm_public_ip]

  tags = merge(
    {
      "Name" = "var.nic_name-${count.index}"
    },
    local.common_tags
  )
}