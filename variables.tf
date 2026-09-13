variable "subscription_id" {
  description = "ID de la suscripción de Azure que contendrá los recursos."
  type        = string
  default     = "3254a23b-4426-4b2e-ad13-45e4bf4bdbbd"
}

variable "location" {
  description = "Región de Azure para todos los recursos."
  type        = string
  default     = "East US 2"
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos del SIEM."
  type        = string
}

variable "vnet_name" {
  description = "Nombre de la red virtual del SIEM."
  type        = string
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la VNet."
  type        = list(string)
}

variable "subnet_name" {
  description = "Nombre de la subred única del SIEM."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Prefijos de la subred única del SIEM."
  type        = list(string)
}

variable "network_security_group_name" {
  description = "Nombre del NSG asociado a la subred."
  type        = string
}

variable "route_table_name" {
  description = "Nombre de la tabla de rutas de la subred."
  type        = string
}

variable "default_route_name" {
  description = "Nombre de la ruta por defecto hacia el firewall."
  type        = string
}

variable "firewall_private_ip" {
  description = "IP privada del Azure Firewall Premium, siguiente salto de la ruta por defecto."
  type        = string
}

variable "load_balancer_name" {
  description = "Nombre del Load Balancer interno Standard."
  type        = string
}

variable "load_balancer_frontend_name" {
  description = "Nombre de la configuración frontend del Load Balancer."
  type        = string
}

variable "load_balancer_backend_pool_name" {
  description = "Nombre del backend pool de los collectors."
  type        = string
}

variable "load_balancer_probe_name" {
  description = "Nombre del health probe TCP."
  type        = string
}

variable "load_balancer_rule_name" {
  description = "Nombre de la regla de balanceo TCP."
  type        = string
}

variable "peer_vnets" {
  description = "Lista de VNets remotas y sus suscripciones para los peerings bidireccionales."
  type = list(object({
    name                = string
    resource_group_name = string
    subscription_id     = string
  }))
}

variable "network_interface_ip_configuration_name" {
  description = "Nombre de la configuración IP de las NIC de los collectors."
  type        = string
}

variable "collectors" {
  description = "Nombres de VM, NIC, disco y host de cada collector."
  type = map(object({
    vm_name       = string
    nic_name      = string
    os_disk_name  = string
    computer_name = string
  }))
}

variable "admin_username" {
  description = "Usuario administrador local de las máquinas Windows."
  type        = string
  sensitive   = true
}

variable "admin_password" {
  description = "Contraseña del administrador local de las máquinas Windows."
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.admin_password) >= 12
    error_message = "La contraseña debe tener al menos 12 caracteres."
  }
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos."
  type        = map(string)
  default = {
    application_name = "SIEM"
    approver_name    = "deyvisward@credicorpcapital.com"
    business_unit    = "TI"
    proyecto         = "SIEM"
    ambiente         = "PR"
  }
}
