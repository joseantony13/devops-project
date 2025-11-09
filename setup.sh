#!/usr/bin/env bash
set -e
# Build app image
docker compose build
# Bring up services
docker compose up -d
echo "Services started. Check docker compose ps"
docker compose ps
