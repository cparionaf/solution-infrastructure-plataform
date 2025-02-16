terraform {
    source = "git::github.com/protecta-security/devsecops-infrastructure-modules.git//eks/operators?ref=v1.0.3"
}

dependency "eks" {
    config_path = "../eks"
}

dependency "vpc" {
    config_path = "../vpc"
}

inputs = {
    cluster_name = dependency.eks.outputs.cluster_name
    cluster_oidc_provider_arn = dependency.eks.outputs.cluster_oidc_provider_arn

    # lb_controller operator
    lb_controller_replicas = 1
    public_subnet_ids = dependency.vpc.outputs.public_subnet_ids
    private_subnet_ids = dependency.vpc.outputs.private_subnet_ids

    # cert_manager operator
    cert_manager_replicas = 1
    notification_email = "aws.management@materiagris.pe"
    domain_name = "nonprod.jiracloud.protectasecuritycloud.pe"

    # external_secrets operator
    external_secrets_replicas = 1

    # external_dns operator
    external_dns_replicas = 1
}