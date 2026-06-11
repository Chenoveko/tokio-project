#!/bin/bash

set -euo pipefail
# =========================================================================================
# TERRAFORM CREATE SCRIPT FOR AWS
# =========================================================================================
# Start timer
START_TIME=$(date +%s)

# Navigate to the directory containing this script
cd "$(dirname "$0")"

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install it."
    exit 1
fi

# Print Terraform version
echo "Printing Terraform version..."
terraform version

# Format Terraform scripts
echo "Formatting Terraform scripts..."
terraform fmt *.tf

# Initialize Terraform plugins
echo "Initializing Terraform plugins..."
terraform init 

# Run Terraform build
# -force: Overwrites any existing output artifacts
# -on-error=ask: Prompts for user input if an error occurs during the build
echo "Starting Terraform build..."
terraform plan -var-file=terraform.tfvars -var-file=secrets.tfvars -out=tfplan
terraform apply tfplan

# End timer
END_TIME=$(date +%s)

# Calculate duration
DURATION=$((END_TIME - START_TIME))

# Format duration
HOURS=$((DURATION / 3600))
MINUTES=$(((DURATION % 3600) / 60))
SECONDS=$((DURATION % 60))

echo ""
echo "========================================="
echo "Create Infra in AWS process completed!"
echo "Total creation time: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo "========================================="