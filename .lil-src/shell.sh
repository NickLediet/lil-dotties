#!/usr/bin/env bash

set -o allexport
source ./config.sh
set +o allexport

docker run -it "${IMAGE_NAME}" bash
