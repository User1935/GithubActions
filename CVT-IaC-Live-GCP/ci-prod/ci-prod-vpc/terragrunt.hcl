terraform {
	source = "git::git@github.com:----//"
}

include {
	path = find_in_parent_folders()
}


inputs = {
	name = "vpc"
}