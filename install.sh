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
}

function create-backup {
	# Create backup directory if it isn't defined
	if [ ! -d "${BACKUP_PATH}" ]; then
		mkdir -p "${BACKUP_PATH}"
	fi

	# Timestamp for backup
	FILE_HASH=$(date +%s)
	# Timestaped & user id'd subdirectory for this particular backup
	CURRENT_BACKUP_SUBDIR="${BACKUP_PATH}/${FILE_HASH}-$(whoami)-backup"

	# Create the directory for this backup
	echo "Creating backup dir at ${CURRENT_BACKUP_SUBDIR}"
	mkdir "${CURRENT_BACKUP_SUBDIR}"

	# Get any unchecked files for backing up (This only checks files that conflict with lil-dotties)
	FILES=$(config checkout 2>&1 | egrep "\s+\." | awk {'print $1'})
	for FILE_PATH in "${FILES}"; do
		echo "THE FILE PATH IS ${FILE_PATH}"
		FILE_NAME=$(basename "${FILE_PATH}"

		# Back em up!
		echo "Backing up ${FILE_PATH} to it's new home @ ${CURRENT_BACKUP_SUBDIR}/${FILE_NAME}..."
		cp "${FILE_PATH}" "${CURRENT_BACKUP_SUBDIR}/${FILE_NAME}"
	done
}

function _install {
	cat <<EOF
███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗     ██╗   ██╗██████╗     
██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝     ██║   ██║██╔══██╗    
███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗    ██║   ██║██████╔╝    
╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║    ██║   ██║██╔═══╝     
███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝    ╚██████╔╝██║██╗██╗██╗
╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝      ╚═════╝ ╚═╝╚═╝╚═╝╚═╝
EOF
	echo "Cloning repository..."
	clone-bare-repo
	config config --unset status.showUntrackedFiles

	echo "Loading libraries..."
	load-lib-code

#	yesno_exit "Do you wish to run the install script for lil-dotties?"

	# Verify if changes have been made and create backups if required
	cat <<EOF
██████╗  █████╗  ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗     ██╗████████╗    ██╗   ██╗██████╗     
██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██║████╗  ██║██╔════╝     ██║╚══██╔══╝    ██║   ██║██╔══██╗    
██████╔╝███████║██║     █████╔╝ ██║██╔██╗ ██║██║  ███╗    ██║   ██║       ██║   ██║██████╔╝    
██╔══██╗██╔══██║██║     ██╔═██╗ ██║██║╚██╗██║██║   ██║    ██║   ██║       ██║   ██║██╔═══╝     
██████╔╝██║  ██║╚██████╗██║  ██╗██║██║ ╚████║╚██████╔╝    ██║   ██║       ╚██████╔╝██║██╗██╗██╗
╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝   ╚═╝        ╚═════╝ ╚═╝╚═╝╚═╝╚═╝
EOF
	config checkout 
	if [ $? = 0 ]; then
		echo "Checked out configuration."
	else
		echo "Backing up existing dotfiles"
		create-backup
	fi


	cat <<EOF
███████╗██╗███╗   ██╗██╗███████╗██╗  ██╗██╗███╗   ██╗ ██████╗          
██╔════╝██║████╗  ██║██║██╔════╝██║  ██║██║████╗  ██║██╔════╝          
█████╗  ██║██╔██╗ ██║██║███████╗███████║██║██╔██╗ ██║██║  ███╗         
██╔══╝  ██║██║╚██╗██║██║╚════██║██╔══██║██║██║╚██╗██║██║   ██║         
██║     ██║██║ ╚████║██║███████║██║  ██║██║██║ ╚████║╚██████╔╝██╗██╗██╗
╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝╚═╝
EOF
	config checkout
	config config --local status.showUntrackedFiles no
	echo 'D-D-D-D-D-D-D-D-D-D-DEBUGGING TIIIIIME!!!!'

	tree -R ~/.lil-backups
}
_install

