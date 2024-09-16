# Resource Block
resource "azurerm_linux_virtual_machine" "ubuntu_vm" {
  # Arguments
  name                = "public_instance"
  resource_group_name = azurerm_resource_group.vm_rg.name
  location            = "East US"
  size                = "Standard_B2s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  computer_name = "ubuntuserverdemo"

  admin_username        = "testuser"
  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "testuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}