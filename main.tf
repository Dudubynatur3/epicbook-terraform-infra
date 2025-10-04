terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateakin"
    container_name       = "tfstate"
    key                  = "epicbook.tfstate"
  }
}

provider "azurerm" {
  features {}
}

locals {
  env_config = {
    dev = {
      location    = "eastus"
      vm_size     = "Standard_B1s"
      allowed_ip  = "85.76.119.90/32" 
      name_prefix = "dev"
    }
    prod = {
      location    = "westeurope"
      vm_size     = "Standard_B2s"
      allowed_ip  = "85.76.119.90/32"
      name_prefix = "prod"
    }
  }

  current_env = local.env_config[terraform.workspace]

  common_tags = {
    Environment = terraform.workspace
    Project     = "EpicBook"
    ManagedBy   = "Terraform"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "${local.current_env.name_prefix}-epicbook-rg"
  location = local.current_env.location
  tags     = local.common_tags
}

module "network" {
  source = "./modules/network"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = "${local.current_env.name_prefix}-epicbook"
  vnet_cidr           = var.vnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  mysql_subnet_cidr   = var.mysql_subnet_cidr
  allowed_ip          = local.current_env.allowed_ip
  tags                = local.common_tags
}

module "database" {
  source = "./modules/database"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = "${local.current_env.name_prefix}-epicbook"
  mysql_subnet_id     = module.network.mysql_subnet_id
  vnet_id             = module.network.vnet_id
  db_admin_username   = var.db_admin_username
  db_admin_password   = var.db_admin_password
  tags                = local.common_tags

  depends_on = [module.network]
}

module "compute" {
  source = "./modules/compute"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  name_prefix         = "${local.current_env.name_prefix}-epicbook"
  vm_size             = local.current_env.vm_size
  public_subnet_id    = module.network.public_subnet_id
  nsg_id              = module.network.public_nsg_id
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  db_host             = module.database.mysql_fqdn
  db_username         = var.db_admin_username
  db_password         = var.db_admin_password
  db_name             = var.db_name
  tags                = local.common_tags

  depends_on = [module.database]
}