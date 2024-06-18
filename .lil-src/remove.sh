#!/usr/bin/env bash

set -o allexport
source ./config.sh
set +o allexport

docker stop "${IMAGE_NAME}"
docker rm "${IMAGE_NAME}"
