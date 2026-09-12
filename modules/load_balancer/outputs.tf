output "backend_pool_id" { value = azurerm_lb_backend_address_pool.this.id }
output "private_ip_address" { value = azurerm_lb.this.frontend_ip_configuration[0].private_ip_address }
