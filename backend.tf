terraform {
  # El backend se configura durante `terraform init` mediante parámetros del pipeline.
  backend "azurerm" {}
}
