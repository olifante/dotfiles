#! /usr/bin/env bash

## prevent referencing undefined variables (which default to "")
set -o nounset
## ignore failing commands
set -o errexit
## make pipe fail when any command in the pipe fails
## use this when using errexit
## Otherwise, it only checks that the last command succeeds
set -o pipefail

find . -type f -name \*.m -or -name \*.h -print0 | xargs -0 /usr/local/bin/uncrustify -l OC -q -c objective-c.cfg --no-backup
