#!/usr/bin/env bash
source ~/.lil-scripts/get-operating-system.sh

function install-mac-deps {
}

function install-linux-deps {

}

# Check OS
OS=$(get-operating-system)
if [[ "${OS}" == "Mac" ]]; then
	mac-instal
fi

