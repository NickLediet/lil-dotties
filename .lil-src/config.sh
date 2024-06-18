#!/usr/bin/env bash 

export IMAGE_NAME="lil-dotties-test-env"
export SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa | base64)
export SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub | base64)
export KNOWN_HOSTS=$(cat ~/.ssh/known_hosts | base64)
