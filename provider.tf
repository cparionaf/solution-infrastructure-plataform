terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.48.0"
    }
  }

  cloud {
    organization = "cparionaf"
    workspaces {
      name = "plataform-dev"
    }
  }
}

provider "aws" {
  region = var.aws_region
}