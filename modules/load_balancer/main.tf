resource "azurerm_lb" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"
  tags                = var.tags

  frontend_ip_configuration {
    name                          = var.frontend_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "this" {
  name            = var.probe_name
  loadbalancer_id = azurerm_lb.this.id
  protocol        = "Tcp"
  port            = 51401
}

resource "azurerm_lb_rule" "this" {
  name                           = var.rule_name
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = 51401
  backend_port                   = 51401
  frontend_ip_configuration_name = var.frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
  disable_outbound_snat          = true
}
