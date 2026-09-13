terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      configuration_aliases = [
        azurerm.local,
        azurerm.remote,
      ]
    }
  }
}

data "azurerm_virtual_network" "remote" {
  provider = azurerm.remote

  name                = var.remote_virtual_network_name
  resource_group_name = var.remote_resource_group_name
}

resource "azurerm_virtual_network_peering" "local_to_remote" {
  provider = azurerm.local

  name                      = "from-${var.local_virtual_network_name}-to-${data.azurerm_virtual_network.remote.name}"
  resource_group_name       = var.local_resource_group_name
  virtual_network_name      = var.local_virtual_network_name
  remote_virtual_network_id = data.azurerm_virtual_network.remote.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "remote_to_local" {
  provider = azurerm.remote

  name                      = "from-${data.azurerm_virtual_network.remote.name}-to-${var.local_virtual_network_name}"
  resource_group_name       = data.azurerm_virtual_network.remote.resource_group_name
  virtual_network_name      = data.azurerm_virtual_network.remote.name
  remote_virtual_network_id = var.local_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
