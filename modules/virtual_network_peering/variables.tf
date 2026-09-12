variable "resource_group_name" { type = string }
variable "virtual_network_name" { type = string }
variable "virtual_network_id" { type = string }
variable "peer_vnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    id                  = string
  }))
}
