locals {
  # Información básica del proyecto se mantiene igual
  project_name = "solutions-architecture-moc"
  organization_name = "cparionaf"
  role_prefix = "plataform"

  # Modificamos cómo obtenemos el ambiente para usar la estructura de directorios
  environment = basename(dirname(dirname(get_original_terragrunt_dir())))

  regions = {
    dev = {
      primary = "us-east-1"  # Dev solo usa una región
    }
    main = {
      primary   = "us-east-1"
      secondary = "us-east-2"  # Producción usa dos regiones
    }
  }

  # Configuración de región se mantiene igual
  region_config = try(
    local.regions[local.environment],
    local.regions["dev"] 
  )

  # Tags comunes se mantienen igual
  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terragrunt"
    Repository  = "solution-architecture-moc"
  }
}

# Configuración de Terraform Cloud se mantiene igual
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

# Modificamos la generación del provider para usar variables en lugar de locals
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

# Declaramos las variables necesarias
variable "region_config" {
  type = object({
    primary = string
    secondary = optional(string)
  })
}

# Provider principal usando la variable
provider "aws" {
  region = var.region_config.primary
}

# Provider secundario solo para producción
${local.environment == "main" ? <<-EOT
provider "aws" {
  alias  = "secondary"
  region = var.region_config.secondary
}
EOT
: ""}
EOF
}

inputs = {
  project_name = local.project_name
  organization_name = local.organization_name
  environment = local.environment
  region_config = local.region_config
  common_tags = local.common_tags
}