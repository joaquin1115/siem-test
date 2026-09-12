locals {
  remote_vnets = {
    for id in var.peer_vnet_ids : id => {
      name                = element(reverse(split("/", id)), 0)
      resource_group_name = split("/", id)[4]
    }
  }
}

resource "azurerm_virtual_network_peering" "local_to_remote" {
  for_each = local.remote_vnets

  name                         = "from-${var.virtual_network_name}-to-${each.value.name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.virtual_network_name
  remote_virtual_network_id    = each.key
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "remote_to_local" {
  for_each = local.remote_vnets

  name                         = "from-${each.value.name}-to-${var.virtual_network_name}"
  resource_group_name          = each.value.resource_group_name
  virtual_network_name         = each.value.name
  remote_virtual_network_id    = var.virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
