#!/bin/bash

set -euo pipefail
# =========================================================================================
# TERRAFORM DESTROY SCRIPT FOR AWS
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

# Load Credentials 
export AWS_ACCESS_KEY_ID=$(grep 'aws_access_key' secrets.tfvars | cut -d'"' -f2)
export AWS_SECRET_ACCESS_KEY=$(grep 'aws_secret_key' secrets.tfvars | cut -d'"' -f2)
export AWS_DEFAULT_REGION=$(grep 'aws_region' terraform.tfvars | cut -d'"' -f2)

# Print Terraform version
echo "Printing Terraform version..."
terraform version

# Run Terraform destroy.sh
echo "Starting Terraform destroy..."
terraform destroy \
  -auto-approve \
  -var-file=terraform.tfvars \
  -var-file=secrets.tfvars

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
echo "Destroy Infra in AWS process completed!"
echo "Total destroy time: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo "========================================="