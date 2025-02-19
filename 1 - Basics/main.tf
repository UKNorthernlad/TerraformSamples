# https://www.youtube.com/watch?v=PD8OR4Tmjxo&list=PLnWpsLZNgHzVVslxs8Bwq19Ng0ff4XlFv

# https://registry.terraform.io/providers/hashicorp/azurerm/latest

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.48.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}

# Locals are the equivalent to variables in an ARM template. These are settings which rarely change.
locals {
  replication = "LRS"
  tags = {
    environment = "Training"
    owner = "bob"
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
# "frog" is the programatic name of this section of code. 
resource "azurerm_resource_group" "frog" {
  name     = "example"
  location = "West Europe"
}

variable "accountname" {
  type = string
  description = "(optional) describe your variable"
  default = "myteststore99x"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "toad" {
  name                     = var.accountname
  resource_group_name      = azurerm_resource_group.frog.name
  location                 = azurerm_resource_group.frog.location
  account_tier             = "Standard"
  account_replication_type = local.replication
  #tags = {
  #  environment = "staging"
  #}
  tags = local.tags
}