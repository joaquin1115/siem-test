terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
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

provider "azurerm" {
  alias           = "peer_vnet_04"
  features        {}
  subscription_id = var.peer_vnets[3].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_05"
  features        {}
  subscription_id = var.peer_vnets[4].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_06"
  features        {}
  subscription_id = var.peer_vnets[5].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_07"
  features        {}
  subscription_id = var.peer_vnets[6].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_08"
  features        {}
  subscription_id = var.peer_vnets[7].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_09"
  features        {}
  subscription_id = var.peer_vnets[8].subscription_id
}

provider "azurerm" {
  alias           = "peer_vnet_10"
  features        {}
  subscription_id = var.peer_vnets[9].subscription_id
}
