resource "azurerm_resource_group" "siem" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source = "./modules/network"

  resource_group_name              = azurerm_resource_group.siem.name
  location                         = azurerm_resource_group.siem.location
  vnet_name                        = var.vnet_name
  vnet_address_space               = var.vnet_address_space
  subnet_name                      = var.subnet_name
  subnet_address_prefixes          = var.subnet_address_prefixes
  network_security_group_name      = var.network_security_group_name
  route_table_name                 = var.route_table_name
  default_route_name               = var.default_route_name
  firewall_private_ip              = var.firewall_private_ip
  load_balancer_name               = var.load_balancer_name
  load_balancer_frontend_name      = var.load_balancer_frontend_name
  load_balancer_backend_pool_name  = var.load_balancer_backend_pool_name
  load_balancer_probe_name         = var.load_balancer_probe_name
  load_balancer_rule_name          = var.load_balancer_rule_name
  peer_vnets                       = var.peer_vnets
  tags                             = var.tags
}

module "compute" {
  source = "./modules/compute"

  resource_group_name = azurerm_resource_group.siem.name
  location            = azurerm_resource_group.siem.location
  subnet_id           = module.network.subnet_id
  backend_pool_id     = module.network.backend_pool_id
  collectors                              = var.collectors
  network_interface_ip_configuration_name = var.network_interface_ip_configuration_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = var.tags
}
