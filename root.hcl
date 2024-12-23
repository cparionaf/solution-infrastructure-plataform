locals {
  # Basic project information
  project_name       = "solutions-architecture-moc"
  organization_name  = "cparionaf"
  role_prefix        = "plataform"

  # Dynamically determine the environment based on directory structure
  environment = basename(dirname(dirname(get_original_terragrunt_dir())))

  # Default region configuration
  aws_region = "us-east-1"

  # Common tags for resources
  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terragrunt"
    Repository  = "solution-architecture-moc"
  }
}

# Terraform Cloud workspace configuration
generate "cloud" {
  path      = "cloud.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  cloud {
    organization = "${local.organization_name}"
    workspaces {
      name = "${local.role_prefix}-${local.environment}"
    }
  }
}
EOF
}

# Provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.48.0"
    }
  }
}

# Define AWS region as a variable
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "${local.aws_region}"
}

provider "aws" {
  region = var.aws_region
}
EOF
}

# Input variables to pass to Terraform modules
inputs = {
  project_name       = local.project_name
  organization_name  = local.organization_name
  environment        = local.environment
  aws_region         = local.aws_region
  common_tags        = local.common_tags
}