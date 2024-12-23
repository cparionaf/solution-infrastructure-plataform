module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}