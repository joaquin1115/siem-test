subscription_id = "3254a23b-4426-4b2e-ad13-45e4bf4bdbbd"
location        = "East US 2"

resource_group_name     = "RSGR-TDI-PR-SIEM-CCC-001"
vnet_name               = "VNET-PR-SIEM-EU2-COM-001"
vnet_address_space      = ["10.173.50.0/28"]
subnet_name             = "SNET-PR-SIEM-EU2-COM-001"
subnet_address_prefixes = ["10.173.50.0/28"]

network_security_group_name     = "NSGR-PR-SIEM-EU2-COM-001"
route_table_name                = "ROTB-PR-SIEM-EU2-COM-001"
default_route_name              = "default-to-azure-firewall"
firewall_private_ip             = "10.169.93.4"
load_balancer_name              = "AZLB-PR-SIEM-EU2-COM-001"
load_balancer_frontend_name     = "internal-frontend"
load_balancer_backend_pool_name = "bindplane-collectors"
load_balancer_probe_name        = "bindplane-tcp-51401"
load_balancer_rule_name                  = "bindplane-tcp-51401"
network_interface_ip_configuration_name = "internal"

peer_vnets = [
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-001"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-001"
    subscription_id     = "09c9e5f2-4b5d-4f4f-8f5c-3ba83c2f1a01"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-002"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-002"
    subscription_id     = "15e5a61a-aad2-478a-af59-5ca257cd6b02"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-003"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-003"
    subscription_id     = "2b7ee3e8-2674-41a0-96e2-f0e1c445e003"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-004"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-004"
    subscription_id     = "3e86c712-82a9-4f21-a2aa-4d196d65f104"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-005"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-005"
    subscription_id     = "4ac3585c-fd59-48bd-b5ee-694df0b32505"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-006"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-006"
    subscription_id     = "5f8d48f6-3f1a-4662-8c8e-838cf7e54606"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-007"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-007"
    subscription_id     = "6a7c5f92-7c32-4f23-9e39-970183076707"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-008"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-008"
    subscription_id     = "7d9836a4-8ebd-4a1b-8f63-a20ee6288808"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-009"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-009"
    subscription_id     = "8bd75c5e-9a7a-4bca-9d51-b3fc4d599909"
  },
  {
    name                = "VNET-MOCK-PR-SIEM-EU2-010"
    resource_group_name = "RSGR-MOCK-PR-NET-EU2-010"
    subscription_id     = "9e5ac8f1-0d4e-4cfb-af32-c4a55e70aa10"
  }
]

collectors = {
  collector_01 = {
    vm_name       = "AZVM-PR-SIEM-EU2-COM-001"
    nic_name      = "ANIC-PR-SIEM-EU2-COM-001"
    os_disk_name  = "DISK-PR-SIEM-EU2-COM-001"
    computer_name = "PRSIEMEU2COM001"
  }
  collector_02 = {
    vm_name       = "AZVM-PR-SIEM-EU2-COM-002"
    nic_name      = "ANIC-PR-SIEM-EU2-COM-002"
    os_disk_name  = "DISK-PR-SIEM-EU2-COM-002"
    computer_name = "PRSIEMEU2COM002"
  }
}

admin_username = "useradmvm"
admin_password = "C4p1t4l2026$$"

tags = {
  application_name = "SIEM"
  approver_name    = "deyvisward@credicorpcapital.com"
  business_unit    = "TI"
  proyecto         = "SIEM"
  ambiente         = "PR"
}
