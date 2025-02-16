locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env_name = local.env_vars.locals.environment
}

terraform {
    source = "git::github.com/protecta-security/devsecops-infrastructure-modules.git//vpc?ref=v1.0.3"
}

inputs = {
  environment = local.env_name
  vpc_id      = "${local.env_name}-devsecops-vpc"
  enabled_tgw_attachment   =  true
  transit_gateway_id       = "tgw-0b3318b41af0d906a"
}