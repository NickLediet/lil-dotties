#!/usr/bin/env bash
REPO_PATH="${HOME}/.lil-dotties"

function yesno_exit() {
  while true
  do
    echo -n "$1 (y or n, defaults to yes): "
    read -r CONFIRM
    case $CONFIRM in
      y|Y|yes|Yes|YES)
        CONFIRM='y';
        break ;;
      n|N|no|No|NO)
        CONFIRM='n';
        echo 'Requirements not met, exiting…'
        exit 1
        break ;;
      *)
        CONFIRM='y';
        break ;;
    esac
  done
}

#printf "Please enter your git credentials for"

function config {
   git --git-dir="${REPO_PATH}" --work-tree=$HOME $@
}
config status
echo 'Worked'

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



