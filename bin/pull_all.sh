#! /usr/bin/env bash

## prevent referencing undefined variables (which default to "")
set -o nounset
## ignore failing commands
set -o errexit
## make pipe fail when any command in the pipe fails
## use this when using errexit
## Otherwise, it only checks that the last command succeeds
set -o pipefail

for i in $(ls -d ./*/); do
    oldcd=$(pwd)
    cd "${i}"
    pwd
    git pull
    cd "${oldcd}"
done
