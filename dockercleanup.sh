#!/bin/bash

# Step 1: Stop Docker Service
echo "👋 Stopping Docker service..."
sudo systemctl stop docker

# Step 2: Remove all containers and images
echo "🧹 Removing all Docker containers and images..."
docker rm -f $(docker ps -aq)
docker image rm -f $(docker image ls -q)

# Clean up unused Docker data
echo "🧽 Pruning unused Docker data..."
docker system prune -af
docker builder prune -af

# Step 3: Remove Docker overlay2 and related directories
echo "🚮 Cleaning up Docker storage directories..."
sudo rm -rf /var/lib/docker/overlay2/ /var/lib/docker/buildkit/ /var/lib/docker/containers/ /var/lib/docker/image/ /var/lib/docker/tmp/ /var/lib/docker/plugins/

# Step 4: Restart Docker Service
echo "🔄 Starting Docker service..."
sudo systemctl start docker
service docker restart

echo "✨ Docker cleanup complete! No more monsters here!"
