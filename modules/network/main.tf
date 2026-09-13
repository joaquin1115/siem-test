resource "azurerm_virtual_network" "siem" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_network_security_group" "siem" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  # Sin reglas personalizadas: Azure conserva las reglas de seguridad predeterminadas.
}

resource "azurerm_route_table" "siem" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  route {
    name                   = var.default_route_name
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.firewall_private_ip
  }
}

resource "azurerm_subnet" "siem" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.siem.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "siem" {
  subnet_id                 = azurerm_subnet.siem.id
  network_security_group_id = azurerm_network_security_group.siem.id
}

resource "azurerm_subnet_route_table_association" "siem" {
  subnet_id      = azurerm_subnet.siem.id
  route_table_id = azurerm_route_table.siem.id
}

resource "azurerm_lb" "siem" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"
  tags                = var.tags

  frontend_ip_configuration {
    name                          = var.load_balancer_frontend_name
    subnet_id                     = azurerm_subnet.siem.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "siem" {
  name            = var.load_balancer_backend_pool_name
  loadbalancer_id = azurerm_lb.siem.id
}

resource "azurerm_lb_probe" "bindplane_tcp" {
  name            = var.load_balancer_probe_name
  loadbalancer_id = azurerm_lb.siem.id
  protocol        = "Tcp"
  port            = 51401
}

resource "azurerm_lb_rule" "bindplane_tcp" {
  name                           = var.load_balancer_rule_name
  loadbalancer_id                = azurerm_lb.siem.id
  protocol                       = "Tcp"
  frontend_port                  = 51401
  backend_port                   = 51401
  frontend_ip_configuration_name = var.load_balancer_frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.siem.id]
  probe_id                       = azurerm_lb_probe.bindplane_tcp.id
  disable_outbound_snat          = true
}

resource "azurerm_virtual_network_peering" "siem_to_remote" {
  for_each = var.peer_vnets

  name                      = "from-${var.vnet_name}-to-${each.value.name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.siem.name
  remote_virtual_network_id = each.value.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "remote_to_siem" {
  for_each = var.peer_vnets

  name                      = "from-${each.value.name}-to-${var.vnet_name}"
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.name
  remote_virtual_network_id = azurerm_virtual_network.siem.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
