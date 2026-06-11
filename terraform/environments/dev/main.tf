module "networking" {
  source = "../../modules/networking"

  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  terraform_managed  = var.terraform_managed
  environment        = var.environment
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.ecr_name
  force_delete = var.force_delete
}