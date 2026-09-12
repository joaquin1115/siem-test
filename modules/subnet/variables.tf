variable "name" { type = string }
variable "resource_group_name" { type = string }
variable "virtual_network_name" { type = string }
variable "address_prefixes" { type = list(string) }
variable "network_security_group_id" { type = string }
variable "route_table_id" { type = string }
