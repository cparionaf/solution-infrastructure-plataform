terraform {
    source = "git::github.com/protecta-security/devsecops-infrastructure-modules.git//eks?ref=v1.0.3"
}

dependency "vpc" {
    config_path = "../vpc"
}

inputs = {
    vpc_id = dependency.vpc.outputs.vpc_id
    private_subnet_ids = dependency.vpc.outputs.private_subnet_ids
    public_subnet_ids = dependency.vpc.outputs.public_subnet_ids
    managed_node_groups = {
        "default_mng" = {
            subnets_ids = dependency.vpc.outputs.private_subnet_ids
        }
    }
    karpenter_replicas = 1
}