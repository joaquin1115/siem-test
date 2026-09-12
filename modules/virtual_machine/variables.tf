variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "subnet_id" { type = string }
variable "backend_pool_id" { type = string }
variable "network_interface_ip_configuration_name" { type = string }
variable "collectors" {
  type = map(object({
    vm_name       = string
    nic_name      = string
    os_disk_name  = string
    computer_name = string
  }))
}
variable "admin_username" {
  type      = string
  sensitive = true
}
variable "admin_password" {
  type      = string
  sensitive = true
}
variable "tags" { type = map(string) }
