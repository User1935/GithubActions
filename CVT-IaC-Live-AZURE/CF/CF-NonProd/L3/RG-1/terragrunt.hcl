terraform {
	source =  "../../../../..//CVT-IaC-Modules-AZURE/vm" #"git::git@github.com:kumarvna/terraform-azurerm-vnet.git" #"../../..//CVT-IaC-Modules-GCP/vpc" #"git::https://github.com/User1935/GithubActions.git//CVT-IaC-Modules-GCP/vpc"
}

include {
	path = find_in_parent_folders()
}


inputs = {
	name = "SomethingnetTest"
	region = "uksouth"
}
