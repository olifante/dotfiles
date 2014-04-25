#! /usr/bin/env bash

## prevent referencing undefined variables (which default to "")
set -o nounset
## ignore failing commands
set -o errexit
## make pipe fail when any command in the pipe fails
## use this when using errexit
## Otherwise, it only checks that the last command succeeds
set -o pipefail

trap "{ reset; exit 1; }" INT

for i in $(ls -d ./*/); do
    oldcd=$(pwd)
    cd "${i}"
    pwd
    if ! git merge origin/master; then
        echo "Error merging ${i}"
    fi
    cd "${oldcd}"
done
