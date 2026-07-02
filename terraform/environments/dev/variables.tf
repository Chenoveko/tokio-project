########################
#      Providers       #
########################
variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
  default     = "eu-south-2"
}

variable "aws_access_key" {
  description = "AWS Access Key used by the Terraform AWS provider"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key used by the Terraform AWS provider"
  type        = string
  sensitive   = true
}

########################
#      Networking      #
########################
variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "techwave-vpc-dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway"
  type        = bool
  default     = false
}

variable "terraform_managed" {
  description = "Terraform tag"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

########################
#         ECR          #
########################
variable "ecr_name" {
  description = "ECR name"
  type        = string
  default     = "ecr-techwave"
}

variable "force_delete" {
  description = "Force delete of ECR if not empty"
  type        = bool
  default     = true
}

########################
#         EKS          #
########################
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_instance_type" {
  description = "Instance type for worker nodes"
  type        = string
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}