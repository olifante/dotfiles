#! /usr/bin/env bash
# Desc  : Deploy dotfiles from repository to home dir.
# Author: Vivien Didelot aka v0n

## prevent referencing undefined variables (which default to "")
set -o nounset
## ignore failing commands
set -o errexit
## make pipe fail when any command in the pipe fails
## use this when using errexit
## Otherwise, it only checks that the last command succeeds
set -o pipefail

REPLACE_ALL=false

function Overwrite {
  rm -rf "$2"
  ln -sv "$1" "$2"
}

function Deploy {
  if test -e "$2" ; then
    if $REPLACE_ALL ; then
      Overwrite "$1" "$2"
    else
      read -p "Overwrite $2? [y/N/a] " QUESTION
      case $QUESTION in
        'y')
          Overwrite "$1" "$2"
          ;;
        a)
          REPLACE_ALL=true
          Overwrite "$1" "$2"
          ;;
        *)
          echo "skipped $2"
          ;;
      esac
    fi
  else
    read -p "Create $2? [y/N] " QUESTION
    case $QUESTION in
      'y')
        test -d "$(dirname $2)" || mkdir -p "$(dirname $2)"
        ln -sv "$1" "$2"
        ;;
      *)
        echo "skipped $2"
        ;;
    esac
  fi
}

for FILE in * ; do
  SRC=$(pwd)/$FILE
  LINK=$HOME/.$FILE

  case $FILE in
    $0|README.markdown|install.sh|pip_freeze.txt)
      ;; # ignore
    bin)
      LINK=$HOME/$FILE
      Deploy "$SRC" "$LINK"
      ;;
    *)
      Deploy "$SRC" "$LINK"
      ;;
  esac
done

exit
