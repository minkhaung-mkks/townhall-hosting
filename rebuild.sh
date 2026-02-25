#!/bin/bash
# Rebuild and restart everything
# Usage: sudo bash rebuild.sh
#
# Expects this folder structure:
#   project-root/
#     townhall-backend/   (its own git repo)
#     frontend/           (its own git repo)
#     dockerfiles/
#     rebuild.sh

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Stopping containers ==="
cd "$PROJECT_DIR/dockerfiles"
docker compose down

echo ""
echo "=== Pulling latest backend ==="
cd "$PROJECT_DIR/townhall-backend"
git pull

echo ""
echo "=== Pulling latest frontend ==="
cd "$PROJECT_DIR/frontend"
git pull

echo ""
echo "=== Building backend image ==="
cd "$PROJECT_DIR/townhall-backend"
docker build -t backend:1.0 .

echo ""
echo "=== Building frontend image ==="
cd "$PROJECT_DIR/frontend"
docker build -t frontend:1.0 .

echo ""
echo "=== Starting containers ==="
cd "$PROJECT_DIR/dockerfiles"
docker compose up -d

echo ""
echo "=== Done! Container status: ==="
docker ps -a
