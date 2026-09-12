# SIEM Collector en Azure con Terraform

Este proyecto aprovisiona en **East US 2** el grupo de recursos `RSGR-TDI-PR-SIEM-CCC-001`, una VNet con una subred, NSG predeterminado, tabla de rutas hacia Azure Firewall, un Load Balancer interno Standard y dos collectors Bindplane Windows Server 2022 en arquitectura activo-activo.

## Estructura

- `main.tf`: crea el grupo de recursos e invoca los módulos.
- `modules/resource_group`, `modules/virtual_network`, `modules/network_security_group`, `modules/route_table` y `modules/subnet`: módulos independientes para el grupo de recursos y cada componente de red.
- `modules/load_balancer`, `modules/virtual_machine` y `modules/virtual_network_peering`: módulos independientes para el balanceador, los collectors y los peerings.
- `environments/production.tfvars`: parámetros de producción, incluidos todos los nombres de recursos, la lista de IDs de VNet para los peerings y las credenciales de administración solicitadas.
- `.github/workflows/terraform.yml`: fases `plan` y `apply` con backend remoto AzureRM y autenticación mediante client ID/client secret.

## Variables que se deben configurar en GitHub

Configure los siguientes **Repository/Environment variables** (se recomienda asociarlos al Environment `production`):

| Variable | Uso |
|---|---|
| `ARM_CLIENT_ID` | Client ID del service principal de GitHub Actions. |
| `ARM_TENANT_ID` | Tenant ID de Microsoft Entra ID. |
| `ARM_SUBSCRIPTION_ID` | Suscripción destino: `3254a23b-4426-4b2e-ad13-45e4bf4bdbbd`. |
| `TFSTATE_RESOURCE_GROUP` | Grupo de recursos existente que contiene el storage account de estado. |
| `TFSTATE_STORAGE_ACCOUNT` | Storage account existente para el estado remoto. |
| `TFSTATE_CONTAINER` | Contenedor blob existente para el estado remoto. |
| `TFSTATE_KEY` | Clave del estado, por ejemplo `siem/production.tfstate`. |

Configure además el siguiente **GitHub Actions secret**:

| Secret | Uso |
|---|---|
| `ARM_CLIENT_SECRET` | Client secret del service principal usado por Azure y el backend AzureRM. |

Las credenciales del administrador de las VMs están definidas en `environments/production.tfvars`, conforme a la configuración solicitada. El service principal necesita permisos **Contributor** sobre el grupo de recursos SIEM y los grupos de recursos de las tres VNets remotas (para los peerings recíprocos). También necesita **Storage Blob Data Contributor** sobre el contenedor de estado. El storage account, contenedor y grupo de recursos del backend deben existir antes de ejecutar el pipeline.

## Ejecución local

Exporte las credenciales del service principal y las credenciales locales como variables de entorno. Después inicialice el backend con los mismos parámetros del pipeline:

```bash
export ARM_CLIENT_ID='<client-id>'
export ARM_CLIENT_SECRET='<client-secret>'
export ARM_TENANT_ID='<tenant-id>'
export ARM_SUBSCRIPTION_ID='3254a23b-4426-4b2e-ad13-45e4bf4bdbbd'
terraform init -backend-config='resource_group_name=<rg-state>' \
  -backend-config='storage_account_name=<storage-state>' \
  -backend-config='container_name=<container-state>' \
  -backend-config='key=siem/production.tfstate'
terraform plan -var-file=environments/production.tfvars
```

## Suposiciones de diseño

- La subred `/28` (16 direcciones, 11 utilizables por Azure) aloja el frontend dinámico del balanceador y las dos NIC privadas; no se crean IPs públicas.
- El listener y health probe TCP se configuran en el puerto `51401`, la única especificación de puerto/protocolo de ingesta recibida. Para UDP, HTTP/HTTPS u otros puertos se deben añadir reglas y probes adicionales.
- El NSG no incluye reglas personalizadas, por lo que se mantienen únicamente las reglas predeterminadas de Azure. Se debe definir explícitamente el control de acceso de ingesta antes de producción si la conectividad de las VNets origen no basta.
- Se crean ambos extremos de cada peering, con nombres `from-VNET-ORIGEN-to-VNET-DESTINO`. Esto exige permisos en `rg-test-vnet` y que no existan peerings equivalentes previamente.
- Azure Firewall Premium (`10.169.93.4`) es enrutable desde esta VNet y tiene reglas que permitan la salida requerida hacia Google SecOps. La UDR no configura las reglas del firewall.
- La instalación y configuración del agente Collector Bindplane, así como la configuración de Google SecOps, quedan fuera de este aprovisionamiento de infraestructura.
