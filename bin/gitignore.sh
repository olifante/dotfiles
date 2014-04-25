#! /usr/bin/env bash

## prevent referencing undefined variables (which default to "")
set -o nounset
## ignore failing commands
set -o errexit
## make pipe fail when any command in the pipe fails
## use this when using errexit
## Otherwise, it only checks that the last command succeeds
set -o pipefail

GITIGNORE_DIR="$HOME/github/gitignore"
for i in Django.gitignore Global/OSX.gitignore Global/SublimeText.gitignore Global/TextMate.gitignore Global/vim.gitignore Objective-C.gitignore Python.gitignore
do
    echo -e "# {{{ https://github.com/github/gitignore/blob/master/$i\n"
    cat "$GITIGNORE_DIR/$i"
    echo -e "# }}} https://github.com/github/gitignore/blob/master/$i\n"
done
