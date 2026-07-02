########################
#      Networking      #
########################
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

########################
#         ECR          #
########################
module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.ecr_name
  force_delete = var.force_delete
}

########################
#         EKS          #
########################
module "eks" {
  source = "../../modules/eks"

  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids   = module.networking.private_subnet_ids  
  vpc_id       = module.networking.vpc_id
  node_instance_type = var.node_instance_type
  node_desired_size = var.node_desired_size
  node_min_size = var.node_min_size
  node_max_size = var.node_max_size
}