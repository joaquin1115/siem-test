terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_01"
  features        {}
  subscription_id = var.peer_vnets[0].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_02"
  features        {}
  subscription_id = var.peer_vnets[1].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_03"
  features        {}
  subscription_id = var.peer_vnets[2].subscription_id
}
