#! /usr/bin/env bash

## prevent referencing undefined variables (which default to "")
set -o nounset
## ignore failing commands
set -o errexit
## make pipe fail when any command in the pipe fails
## use this when using errexit
## Otherwise, it only checks that the last command succeeds
set -o pipefail

if [ ! -n "$1" ]; then
    echo "Syntax is: uncrustify.sh dirname filesuffix"
    echo "Syntax is: uncrustify.sh filename"
    echo "Example: uncrustify.sh temp cpp"
    exit 1
fi

if [ -d "$1" ]; then
    #echo "Dir ${1} exists"
    if [ -n "$2" ]; then
        filesuffix=$2
    else
        filesuffix="*"
    fi

    #echo "Filtering files using suffix ${filesuffix}"

    file_list=$(find "${1}" -name "*.${filesuffix}" -type f)
    for file2indent in $file_list
    do
        echo "Indenting file $file2indent"
    "/usr/local/bin/uncrustify" -f "$file2indent" -c "./objective-c.cfg" -o indentoutput.tmp
    mv indentoutput.tmp "$file2indent"

    done
    else
        if [ -f "$1" ]; then
            echo "Indenting one file $1"
    "/usr/local/bin/uncrustify" -f "$1" -c "./objective-c.cfg" -o indentoutput.tmp
    mv indentoutput.tmp "$1"

    else
        echo "ERROR: As parameter given directory or file does not exist!"
        echo "Syntax is: uncrustify.sh dirname filesuffix"
        echo "Syntax is: uncrustify.sh filename"
        echo "Example: uncrustify.sh temp cpp"
        exit 1
    fi
fi
