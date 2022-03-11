# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
# ${path_relative_from_include()}
# "${path_relative_from_include()}/secure/stuff.yaml"

#locals {
#  subscription = read_terragrunt_config(find_in_parent_folders("sub.hcl"))
#
#  # Extract the variables we need for easy access
#  subscription_id = local.subscription.locals.subscription_id
#}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  subscription_id = data.sops_file.secrets.data["azure.azsubscription_id"]
  tenant_id 	  = data.sops_file.secrets.data["azure.aztenant_id"]
  client_id	      = data.sops_file.secrets.data["azure.azclient_id"]
  client_secret   = data.sops_file.secrets.data["azure.azclient_secret"]
  features {}
}
locals {
  sops_file_path = split("/",abspath(path.root))
}
data "sops_file" "secrets" {
  source_file = join("/",["",local.sops_file_path[1],local.sops_file_path[2],local.sops_file_path[3],local.sops_file_path[4], local.sops_file_path[5],"secure/stuff.yaml"]) 
  input_type  = "yaml"
}
EOF
}

generate "terraform" {
  path      = "terraform.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_version = ">=1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.77"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 0.6"
    }
    azureread = {
      source  = "hashicorp/azuread"
      version = "~> 2.4.0"
    }
  }
}
EOF
}

# Key Changed
remote_state {
  backend = "azurerm"
  config = {
   resource_group_name  = "rg-LA-test-storage-gitops"
    storage_account_name = "gitacttfstatestorage"
    container_name       = "tfstate"
    key = "${path_relative_to_include()}/test.tfstate"
    access_key = get_env("STORAGE_KEY")

  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

#inputs = merge(
#  local.account_vars.locals,
#  local.region_vars.locals,
#  local.environment_vars.locals,
#)
