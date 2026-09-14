# SIEM Corporativo

Este proyecto aprovisiona en **East US 2** el grupo de recursos `RSGR-TDI-PR-SIEM-CCC-001`, una VNet con una subred, NSG predeterminado, tabla de rutas hacia Azure Firewall, un Load Balancer interno Standard y dos collectors Bindplane Windows Server 2022 en arquitectura activo-activo.

## Estructura

- `main.tf`: crea el grupo de recursos e invoca los módulos.
- `modules/resource_group`, `modules/virtual_network`, `modules/network_security_group`, `modules/route_table` y `modules/subnet`: módulos independientes para el grupo de recursos y cada componente de red.
- `modules/load_balancer`, `modules/virtual_machine` y `modules/virtual_network_peering`: módulos independientes para el balanceador, los collectors y los peerings.
- `environments/production.tfvars`: parámetros de producción, incluidos todos los nombres de recursos, la lista de VNets (nombre, resource group y suscripción) para los peerings y el usuario de administración.

## Contraseña de administración

Terraform genera aleatoriamente la contraseña de administración al crear la infraestructura y la conserva en el estado para no regenerarla en ejecuciones posteriores. Los cambios manuales de esta contraseña desde el portal de Azure se ignoran durante los despliegues posteriores, por lo que el pipeline no la restablece.

> La contraseña generada es sensible y queda almacenada en el estado de Terraform. Proteja el backend de estado y limite el acceso a este archivo.
