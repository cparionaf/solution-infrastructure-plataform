include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../.."
}

inputs = {
  environment = "main"
  single_nat_gateway = false
}
