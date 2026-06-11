#!/bin/bash

set -euo pipefail
# =========================================================================================
# PACKER BUILD SCRIPT FOR TECH WAVE APP IMAGE
# =========================================================================================
# Start timer
START_TIME=$(date +%s)

# Navigate to the directory containing this script
cd "$(dirname "$0")"

# Check if Packer is installed
if ! command -v packer &> /dev/null; then
    echo "Packer is not installed. Please install it from https://www.packer.io/downloads"
    exit 1
fi

# Check if secrets file exists
if [ ! -f "secrets.pkrvars.hcl" ]; then
    echo "Creating example secrets file..."
    cp secrets.pkrvars.hcl.example secrets.pkrvars.hcl
    echo "Please edit secrets.pkrvars.hcl with your actual credentials before running this script again."
    exit 1
fi

# Print Packer version
echo "Printing Packer version..."
packer version

# Format Packer scripts
echo "Formatting Packer scripts..."
packer fmt *.hcl

# Initialize Packer plugins
echo "Initializing Packer plugins..."
packer init tech_wave_app_image.pkr.hcl

# Run Packer build
# -force: Overwrites any existing output artifacts
# -on-error=ask: Prompts for user input if an error occurs during the build
echo "Starting Packer build..."
packer build --force --on-error=ask \
  -var-file=variables.pkrvars.hcl \
  -var-file=secrets.pkrvars.hcl \
  tech_wave_app_image.pkr.hcl

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
echo "Build process completed!"
echo "Total build time: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo "========================================="