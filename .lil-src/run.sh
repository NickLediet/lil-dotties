#!/usr/bin/env bash

set -o allexport
source ./config.sh
set +o allexport

docker run --name "${IMAGE_NAME}" -d "${IMAGE_NAME}:latest"

