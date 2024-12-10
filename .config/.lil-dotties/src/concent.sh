#!/usr/bin/env bash

function concent {
  read -p "$1 (y or n, defaults to yes): " -n 1 -r confirm
  if [[ ! $confirm =~ ^[Yy]$ ]]; then
    return 1
  fi

  return 0
}

export -f concent
