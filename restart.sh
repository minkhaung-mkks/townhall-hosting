#!/bin/bash
# Restart containers without rebuilding
# Usage: sudo bash restart.sh

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$PROJECT_DIR/dockerfiles"

echo "=== Stopping containers ==="
docker compose down

echo ""
echo "=== Starting containers ==="
docker compose up -d

echo ""
echo "=== Done! Container status: ==="
docker ps -a
