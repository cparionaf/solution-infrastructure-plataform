module "vpc" {
  source = "./modules/vpc"
  environment = var.environment
  single_nat_gateway = var.single_nat_gateway
}

module "iam" {
  source = "./modules/iam"
  environment = var.environment
}