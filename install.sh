#!/usr/bin/env bash
REPO_PATH="${HOME}/.lil-dotties"
SCRIPTS_PATH="${HOME}/.lil-scripts"
BACKUP_PATH="${HOME}/.lil-backups"

# Bring in lib code
function load-lib-code {
	for f in "${SCRIPTS_PATH}"/*; do
		[ -e "$f" ] || continue
		source $f
	done
}

function config {
   git --git-dir="${REPO_PATH}" --work-tree="${HOME}" $@
}

function clone-bare-repo {
	git clone --bare https://github.com/NickLediet/lil-dotties.git "${REPO_PATH}"
	#git clone --bare git@github.com:NickLediet/lil-dotties.git "${REPO_PATH}"
}

function create-backup {
	if [ ! -d "${BACKUP_PATH}" ]; then
		mkdir -p "${BACKUP_PATH}"
	fi

	FILE_HASH=$(date +%s)
	CURRENT_BACKUP_SUBDIR="${BACKUP_PATH}/${FILE_HASH}-$(whoami)-backup"

	mkdir "${CURRENT_BACKUP_SUBDIR}"
	FILES=$(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'})
	for FILE_PATH in "${FILES}"; do
		echo "${FILE_PATH}"
	done
#	xargs -I{} mkdir -p {} "${CURRENT_BACKUP_SUBDIR}"/{} 
#	xargs -I{} mv {} "${CURRENT_BACKUP_SUBDIR}"/{} 
}

function _install {
	clone-bare-repo
	config config --unset status.showUntrackedFiles
	load-lib-code
	yesno_exit "Do you wish to run the install script for lil-dotties?"
	# Verify if changes have been made and create backups if required
	config checkout 
	if [ $? = 0 ]; then
		echo "Checked out configuration."
	else
		echo "Backing up existing dotfiles"
		create-backup
	fi
	config checkout
	config config --local status.showUntrackedFiles no
		
}
_install

# Todo:
# - [ ] Prove install script works (First GREEN)
# - [ ] Add install script to repo
# - [ ] Write actual curl & clone logic for installation script

# # Clone as a bare repo at ~/.lil-dotties
# git clone --bare git@github.com:NickLediet/lil-dotties.git "${REPO_PATH}"

# # Typically `config checkout` is an expensive do nothing command (according to `man git checkout` at least
# # In this case we're checking for the status code of doging that to see if there were issues pulling and this creating a back up
# config checkout
# if [ $? = 0 ]; then 
# 	echo "Checked out lil dotties"
# else
#     echo "Backing up pre-existing dot files.";
#     config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
# fi;
# config checkout 
# config config status.showUntrackedFiles no



