#!/usr/bin/env sh

function yesno_exit() {
  while true
  do
    echo -n "$1 (y or n, defaults to yes): "
    read -pr CONFIRM
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

export -f yesno_exit
