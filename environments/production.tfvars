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
    name                = "vnet-test-01"
    resource_group_name = "rg-test-vnet"
    subscription_id     = "3254a23b-4426-4b2e-ad13-45e4bf4bdbbd"
  },
  {
    name                = "vnet-test-02"
    resource_group_name = "rg-test-vnet"
    subscription_id     = "3254a23b-4426-4b2e-ad13-45e4bf4bdbbd"
  },
  {
    name                = "vnet-test-03"
    resource_group_name = "rg-test-vnet"
    subscription_id     = "3254a23b-4426-4b2e-ad13-45e4bf4bdbbd"
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
