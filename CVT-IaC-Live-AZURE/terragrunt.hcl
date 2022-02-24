# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------


locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.account_id
  gcp_region   = local.region_vars.locals.region
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  subscription_id = data.sops_file.secrets.data["azure.azsubscription_id"]
  tenant_id 	  = data.sops_file.secrets.data["azure.aztenant_id"]
  client_id		  = data.sops_file.secrets.data["azure.azclient_id"]
  client_secret   = data.sops_file.secrets.data["azure.azclient_secret"]
  features {}
}

data "sops_file" "secrets" {
  source_file = "${path_relative_from_include()}/secure/stuff.yaml"
  input_type = "yaml"
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
			source = "hashicorp/azurerm"
			version = "~> 2.77"
		}
		sops = {
			source = "carlpett/sops"
			version = "~> 0.6"
		}
		azureread = {
			source = "hashicorp/azuread"
			version = "~> 2.4.0"
		}
	}
}
EOF
}

#terraform {
#	before_hook "tf_plugins" {
#		  commands = ["init", "format", "plan", "apply", "validate"]
#
#		  run_on_error = false
#
#		  execute = [
#			"bash", "-c", "touch provider-sop.tf;echo 'provider \"sops\" {\n source = \"carlpett/sops\"\nversion = \"~> 0.6\"\n}' > provider-sop.tf"
#		  ]
#	}
#}

#   source = "carlpett/sops"
# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "azurerm"
  config = {
   resource_group_name  = "rg-LA-test-storage-gitops"
    storage_account_name = "gitacttfstatestorage"
    container_name       = "tfstate"
    key = "test.tfstate"
    access_key = get_env("STORAGE_KEY")

  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)
