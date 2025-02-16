# Backend configuration
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "protecta-${get_aws_account_id()}-devsecops-terraform-state"
    # Project, Subproject, Environment, Component
    key            = "infrastructure/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "protecta-devops-terraform-locks"
    
    # Configuraciones recomendadas para el bucket
    s3_bucket_tags = {
      Owner       = "Infrastructure Team"
      Project     = "DevSecOps"
      ManagedBy     = "Terraform"
    }
    
    # Configuraciones recomendadas para la tabla DynamoDB
    dynamodb_table_tags = {
      Owner       = "Infrastructure Team"
      Project     = "DevSecOps"
      ManagedBy     = "Terraform"
    }
  }
}

# Configure the AWS provider

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}

# Shared Inputs of the project

inputs = {  
    region = "us-east-1"
    tags = {
    Environment = ""
    Project     = "DevSecOps"
    Owner       = "Infrastructure Team"
    Managed     = "Terragrunt"
  }
}