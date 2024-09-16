resource "azurerm_resource_group" "vnet_demo_rg" {
  name     = var.resource_group_name
  location = var.region

  tags = merge(
    {
      "Name" = "virtualnetworkdemo"
    },
    local.common_tags
  )
}