#!/usr/env/bin sh


function prompt-git-creds {
	read -p "What is your git email?   " GIT_EMAIL
	read -p "What is your fullname for git?   " GIT_NAME

	git config --global user.email "${GIT_EMAIL}"
	git config --global user.name "${GIT_NAME}"

	cat <<EOF
The following commands were excuted:
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
EOF
}


