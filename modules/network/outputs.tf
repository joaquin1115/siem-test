output "subnet_id" {
  value = azurerm_subnet.siem.id
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.siem.id
}

output "load_balancer_private_ip" {
  value = azurerm_lb.siem.frontend_ip_configuration[0].private_ip_address
}
