variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "vnet_address_space" { type = list(string) }
variable "subnet_name" { type = string }
variable "subnet_address_prefixes" { type = list(string) }
variable "network_security_group_name" { type = string }
variable "route_table_name" { type = string }
variable "default_route_name" { type = string }
variable "firewall_private_ip" { type = string }
variable "load_balancer_name" { type = string }
variable "load_balancer_frontend_name" { type = string }
variable "load_balancer_backend_pool_name" { type = string }
variable "load_balancer_probe_name" { type = string }
variable "load_balancer_rule_name" { type = string }
variable "peer_vnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    id                  = string
  }))
}
variable "tags" { type = map(string) }
