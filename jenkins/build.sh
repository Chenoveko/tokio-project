#!/bin/bash

set -euo pipefail
# =========================================================================================
# DOCKER BUILD SCRIPT FOR JENKINS ON TOKIO VM
# =========================================================================================
# Start timer
START_TIME=$(date +%s)

# Navigate to the directory containing the files
cd "$(dirname "$0")/docker"

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "docker is not installed. Please install it."
    exit 1
fi

# Print Docker version
echo "Printing Docker version..."
docker version

# Print Docker compose version
echo "Printing Docker compose version..."
docker compose version

# Build Jenkins image
echo "Initializing building Jenkins image..."
docker build -t homelab-jenkins .

# Run Docker compose to start Jenkins container
echo "Starting Jenkins container..."
docker compose up -d

# Print Jenkins Initial Administrator password
echo "Waiting for Jenkins to initialize..."
echo "Jenkins Initial Administrator password:"
sleep 60
docker exec homelab-jenkins cat /var/jenkins_home/secrets/initialAdminPassword

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
echo "Jenkins Build process completed!"
echo "Total build time: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo "========================================="