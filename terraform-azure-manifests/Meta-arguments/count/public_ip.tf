resource "azurerm_public_ip" "vm_public_ip" {
  count               = var.count_number
  name                = "var.public_ip_name-${count.index}"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = var.region_code
  allocation_method   = "Static"

  tags = local.common_tags
}