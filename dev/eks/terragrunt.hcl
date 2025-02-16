include "root" {
  path = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

include "env" {
  path = "${get_terragrunt_dir()}/../../_env/eks.hcl"
  merge_strategy = "deep"
}

inputs = {
  environment = "dev"
}