# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "2gXP12wtlIONzDMbuoauUEO8VSyI7VwASmw7oYKxy+s01RyZPkvw26FnyovNiuxra73KfOgYK3597m5hBGPr3w=="
    resource_group_name  = "rg-LA-test-storage-gitops"
    storage_account_name = "gitacttfstatestorage"
  }
}