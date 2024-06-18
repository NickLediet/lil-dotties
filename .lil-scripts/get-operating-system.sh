#!/usr/bin/env sh

# See SO Post this is ripped from: https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
function get-opertaing-system {
	unameOut="$(uname -s)"
	case "${unameOut}" in
	    Linux*)     machine=Linux;;
	    Darwin*)    machine=Mac;;
	    CYGWIN*)    machine=Cygwin;;
	    MINGW*)     machine=MinGw;;
	    MSYS_NT*)   machine=Git;;
	    *)          machine="UNKNOWN:${unameOut}"
	esac
	echo ${machine}
}
