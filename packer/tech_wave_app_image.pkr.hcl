# ========= Packer Block =========#
packer {
  required_plugins {
    docker = {
      version = ">= 1.1.3"
      source  = "github.com/hashicorp/docker"
    }

  }
}

# ========= Vars Block =========#
variable "aws_region" {
  description = "AWS region where the resources are deployed and the ECR repository is located."
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID where the ECR repository is hosted."
  type        = string
}


variable "ecr_registry" {
  description = "ECR registry URL. Example: 123456789012.dkr.ecr.eu-west-1.amazonaws.com."
  type        = string
}

variable "ecr_repo" {
  description = "Full ECR repository name where the Docker image will be stored."
  type        = string
}

variable "image_tag" {
  description = "Docker image tag to be assigned before pushing the image to ECR."
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key ID used to authenticate with AWS."
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key used to authenticate with AWS."
  type        = string
  sensitive   = true
}

# ========= Locals Block =========#
# Generate timestamp to use naming images, every build generates a unique name 
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

# ========= Source Block =========#
# Base image
source "docker" "techwave" {
  image  = "node:alpine3.21"   
  commit = true
}

# ========= Build Block =========#
build {
  sources = ["source.docker.techwave"]

  provisioner "shell" {
    inline = [
      "mkdir -p /app",
      "cd /app",
    ]
  }

  provisioner "file" {
    source      = "../techwave-app/package.json"
    destination = "/app/package.json"
  }

  provisioner "file" {
    source      = "../techwave-app/package-lock.json"
    destination = "/app/package-lock.json"
  }

  provisioner "shell" {
    inline = ["cd /app && npm ci"]
  }

  provisioner "file" {
    source      = "../techwave-app/"
    destination = "/app"
  }

  provisioner "shell" {
    inline = ["cd /app && npm run build"]
  }

  # Tag + Push to ECR
  post-processors {
    post-processor "docker-tag" {
      repository = "${var.ecr_registry}/${var.ecr_repo}"
      tags       = ["${var.image_tag}-${local.timestamp}"]
    }

    post-processor "docker-push" {
      ecr_login    = true
      login_server = var.ecr_registry
      aws_access_key = var.aws_access_key
      aws_secret_key = var.aws_secret_key
    }
  }
}