#!/bin/sh

set -e

echo "Cleaning up Localstack ..."
docker compose \
  -f ./../.docker/docker-compose.yml \
  --env-file ./../.docker/.env stop
docker compose \
  -f ./../.docker/docker-compose.yml \
  --env-file ./../.docker/.env down -v
  