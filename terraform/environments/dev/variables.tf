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
