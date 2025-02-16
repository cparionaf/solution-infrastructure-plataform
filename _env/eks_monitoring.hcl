terraform {
    source = "git::github.com/protecta-security/devsecops-infrastructure-modules.git//eks/monitoring?ref=v1.0.3"
}

dependency "eks" {
    config_path = "../eks"
}

inputs = {
    prometheus_replicas = 1
    domain_name = "nonprod.jiracloud.protectasecuritycloud.pe"
}