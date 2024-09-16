output "vm_public_ip" {
  value       = azurerm_linux_virtual_machine.ubuntu_vm.*.public_ip_address
  description = "Virtual Machine Public IP address"
}

output "vm_private_ip" {
  value       = azurerm_linux_virtual_machine.ubuntu_vm.*.private_ip_address
  description = "Virtual Machine Private IP address"
}