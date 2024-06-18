#!/usr/bin/env bash
set -o allexport
source ./config.sh
set +o allexport

# Build the container with dynamic args for ssh keys
docker build \
	--no-cache \
	--build-arg KNOWN_HOSTS="${KNOWN_HOSTS}" \
	--build-arg SSH_PRIVATE_KEY="${SSH_PRIVATE_KEY}" \
       	--build-arg SSH_PUBLIC_KEY="${SSH_PUBLIC_KEY}" \
	-t "${IMAGE_NAME}:latest" \
	.

# Run detached container
#docker run --name "${IMAGE_NAME}" -d "${IMAGE_NAME}:latest"
	
# Connect to a bash session of the container
# docker exec -it lil-src-app-1 bash

#docker-compose up --build -d && docker exec -it lil-src-app-1 bash
