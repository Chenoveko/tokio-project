#!/bin/bash

set -euo pipefail
# =========================================================================================
# DOCKER CLEAN SCRIPT FOR JENKINS ON TOKIO VM
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

# Stop and remove containers
echo "Stopping and removing containers..."
docker compose down

# Remove volumes
echo "Removing Jenkins volumes..."
docker volume ls -q | xargs -r docker volume rm

# Remove docker images
echo "Removing docker images..."
docker image ls -q | xargs -r docker rmi

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
echo "Jenkins Clean process completed!"
echo "Total clean time: ${HOURS}h ${MINUTES}m ${SECONDS}s"
echo "========================================="