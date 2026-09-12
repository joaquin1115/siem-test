resource "azurerm_network_interface" "this" {
  for_each = var.collectors

  name                = each.value.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = var.network_interface_ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  for_each = var.collectors

  network_interface_id    = azurerm_network_interface.this[each.key].id
  ip_configuration_name   = var.network_interface_ip_configuration_name
  backend_address_pool_id = var.backend_pool_id
}

resource "azurerm_windows_virtual_machine" "this" {
  for_each = var.collectors

  name                = each.value.vm_name
  computer_name       = each.value.computer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_D4lds_v5"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.this[each.key].id,
  ]
  provision_vm_agent = true
  tags               = var.tags

  os_disk {
    name                 = each.value.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsserver"
    offer     = "windowsserver2022"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}
