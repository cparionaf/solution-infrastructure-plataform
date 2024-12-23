include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../modules/iam"
}

inputs = {
  environment = "dev"
}

include "vpc" {
  config_path = "../vpc"
}


