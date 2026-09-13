module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "virtual_network" {
  source = "./modules/virtual_network"

  name                = var.vnet_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

module "network_security_group" {
  source = "./modules/network_security_group"

  name                = var.network_security_group_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "route_table" {
  source = "./modules/route_table"

  name                = var.route_table_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  default_route_name  = var.default_route_name
  firewall_private_ip = var.firewall_private_ip
  tags                = var.tags
}

module "subnet" {
  source = "./modules/subnet"

  name                      = var.subnet_name
  resource_group_name       = module.resource_group.name
  virtual_network_name      = module.virtual_network.name
  address_prefixes          = var.subnet_address_prefixes
  network_security_group_id = module.network_security_group.id
  route_table_id            = module.route_table.id
}

module "load_balancer" {
  source = "./modules/load_balancer"

  name                = var.load_balancer_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.subnet.id
  frontend_name       = var.load_balancer_frontend_name
  backend_pool_name   = var.load_balancer_backend_pool_name
  probe_name          = var.load_balancer_probe_name
  rule_name           = var.load_balancer_rule_name
  tags                = var.tags
}

module "virtual_machine" {
  source = "./modules/virtual_machine"

  resource_group_name                     = module.resource_group.name
  location                                = module.resource_group.location
  subnet_id                               = module.subnet.id
  backend_pool_id                         = module.load_balancer.backend_pool_id
  network_interface_ip_configuration_name = var.network_interface_ip_configuration_name
  collectors                              = var.collectors
  admin_username                          = var.admin_username
  admin_password                          = var.admin_password
  tags                                    = var.tags
}

module "virtual_network_peering_01" {
  source = "./modules/virtual_network_peering"

  providers = {
    azurerm.local  = azurerm
    azurerm.remote = azurerm.peer_vnet_01
  }

  local_resource_group_name    = module.resource_group.name
  local_virtual_network_name   = module.virtual_network.name
  local_virtual_network_id     = module.virtual_network.id
  remote_resource_group_name   = var.peer_vnets[0].resource_group_name
  remote_virtual_network_name  = var.peer_vnets[0].name
}

module "virtual_network_peering_02" {
  source = "./modules/virtual_network_peering"

  providers = {
    azurerm.local  = azurerm
    azurerm.remote = azurerm.peer_vnet_02
  }

  local_resource_group_name    = module.resource_group.name
  local_virtual_network_name   = module.virtual_network.name
  local_virtual_network_id     = module.virtual_network.id
  remote_resource_group_name   = var.peer_vnets[1].resource_group_name
  remote_virtual_network_name  = var.peer_vnets[1].name
}

module "virtual_network_peering_03" {
  source = "./modules/virtual_network_peering"

  providers = {
    azurerm.local  = azurerm
    azurerm.remote = azurerm.peer_vnet_03
  }

  local_resource_group_name    = module.resource_group.name
  local_virtual_network_name   = module.virtual_network.name
  local_virtual_network_id     = module.virtual_network.id
  remote_resource_group_name   = var.peer_vnets[2].resource_group_name
  remote_virtual_network_name  = var.peer_vnets[2].name
}
