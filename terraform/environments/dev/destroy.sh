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
echo "Destroy process completed!"
echo "Total destroy time: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo "========================================="