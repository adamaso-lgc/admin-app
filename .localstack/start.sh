#!/bin/bash

set -e

echo "Starting Localstack ..."
docker compose \
  -f ./../.docker/docker-compose.yml \
  --env-file ./../.docker/.env \
  rm -svf
docker compose \
  -f ./../.docker/docker-compose.yml \
  --env-file ./../.docker/.env \
  up -d

echo "Checking LocalStack health..."
until $(curl --output /dev/null --silent --head --fail http://localhost:4566/health); do
    printf '.'
    sleep 5
done
echo "LocalStack is ready."

cd ./../.terraform/environments/local

echo "Initializing Terraform..."
tflocal init -reconfigure

echo "Validating Terraform configuration..."
tflocal validate

echo "Applying Terraform configurations..."
tflocal apply -compact-warnings --auto-approve

echo "Terraform has been applied successfully."