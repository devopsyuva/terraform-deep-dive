# Resource Block
resource "azurerm_linux_virtual_machine" "ubuntu_vm" {
  # Meta-aruments
  count               = var.count_number
  name                = "public_instance-${count.index}"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = var.region_code
  size                = "Standard_B2s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  computer_name = "ubuntuserverdemo"

  admin_username        = "testuser"
  network_interface_ids = [element(azurerm_network_interface.vm_nic.*.id, count.index)]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  #Install Nginx package and pass custom index.html file

  admin_ssh_key {
    username   = "testuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  tags = merge(
    {
      "Name" = "public_instance-${count.index}"
    },
    local.common_tags
  )
}