########################
#         ECR          #
########################
output "ecr_url" {
  value = module.ecr.repository_url
}

########################
#         EKS          #
########################
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value     = module.eks.cluster_endpoint
  sensitive = true
}