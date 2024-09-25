#!/usr/bin/env bash
REPO_PATH="${HOME}/.lil-dotties"
SCRIPTS_PATH="${HOME}/.lil-scripts"
BACKUP_PATH="${HOME}/.lil-backups"

# Bring in lib code
function load-lib-code {
	FILES=$(ls "$SCRIPTS_PATH")

	set -a
	for f in $FILES; do
		file_path="${SCRIPTS_PATH}/${f}"
		cat $file_path
		echo "$file_path is being loaded..."
		source "${file_path}"
	done
	set +a
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
		FILE_NAME=$(basename "${FILE_PATH}")

		# Back em up!
		echo "Backing up ${FILE_PATH} to it's new home @ ${CURRENT_BACKUP_SUBDIR}/${FILE_NAME}..."
		mv "${FILE_PATH}" "${CURRENT_BACKUP_SUBDIR}/${FILE_NAME}"
	done
}


# Installtion steps for installing tmux plugin manager
function install_tpm {
	# Install TPM
	local tpm_path="${HOME}/.tmux/plugins/tpm"
	if [ -d "${tpm_path}" ]; then
		echo "TPM already installed"
		return
	fi

	git clone https://github.com/tmux-plugins/tpm "${tpm_path}"
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
	if [ ! -d "${REPO_PATH}" ]; then
		echo "Cloning repository..."
		clone-bare-repo
	else
		echo "Repo already exists, moving to backups step"
	fi
	config config --unset status.showUntrackedFiles
#	yesno_exit "Do you wish to run the install script for lil-dotties?"

	# Verify if changes have been made and create backups if required
	cat <<EOF
██████╗  █████╗  ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗     ██╗████████╗    ██╗   ██╗██████╗ ██╗
██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██║████╗  ██║██╔════╝     ██║╚══██╔══╝    ██║   ██║██╔══██╗██║
██████╔╝███████║██║     █████╔╝ ██║██╔██╗ ██║██║  ███╗    ██║   ██║       ██║   ██║██████╔╝██║
██╔══██╗██╔══██║██║     ██╔═██╗ ██║██║╚██╗██║██║   ██║    ██║   ██║       ██║   ██║██╔═══╝ ╚═╝
██████╔╝██║  ██║╚██████╗██║  ██╗██║██║ ╚████║╚██████╔╝    ██║   ██║       ╚██████╔╝██║     ██╗
╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝   ╚═╝        ╚═════╝ ╚═╝     ╚═╝

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
	config checkout --force
	config config --local status.showUntrackedFiles no

	cat <<EOF
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ██╗███╗   ██╗ ██████╗          
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██║████╗  ██║██╔════╝          
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     ██║██╔██╗ ██║██║  ███╗         
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██║██║╚██╗██║██║   ██║         
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗██║██║ ╚████║╚██████╔╝██╗██╗██╗
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝╚═╝
                                                                                     
EOF
	echo "Loading libraries..."
	load-lib-code

	OS=$(get-operating-system)
	case "$OS" in
		Mac)
			brew install jq
			brew install yq
			brew install jandedobbeleer/oh-my-posh/oh-my-posh
			brew install tmux
			install_tpm
			brew install --cask font-ubuntu-mono-nerd-font
			brew install fzf
			brew install zoxide
			brew install gitleaks
			brew install wget
			brew install neovim
      git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

      # Install Java environment
      brew tap AdoptOpenJDK/AdoptOpenJDK
      brew tap homebrew/cask-versions
      brew install --cask termurin@11
      brew install --cask termurin@17
      brew install --cask termurin@21

      brew install jenv
      jenv add /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home
      jenv add /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
      jenv add /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
      brew install maven
      brew install apache-flink
      brew install redis
      # To start, run `cassandra -f&` or `brew services start cassandra`
      brew install cassandra
      # END Java env installation 

      # Mac Only packages/apps
      brew install --cask raycast

			;;
		Linux)
			VERSION='v4.44.2'
			BINARY='yq_linux_amd64'
			if [[ ! -z "${HOME}/.local/bin" ]]; then
				mkdir -p "${HOME}/.local/bin"
			fi
			apt install jq
			wget "https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}" -O "${HOME}/.local/bin/yq" && chmod +x "${HOME}/.local/bin/yq"
			curl -s https://ohmyposh.dev/install.sh | bash -s
			apt install tmux
			install_tpm
			sudo apt install fzf
			sudo apt install zoxide
			sudo apt install neovim
      git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

      # Todo: Add port of Java installation steps from mac workflow.
      #       Maybe use sdkman: https://sdkman.io/
			;;
	esac
}
_install

