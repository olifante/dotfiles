#!/bin/bash
# desc  : deploy dotfiles from repository to home dir.
# author: Vivien Didelot aka v0n

REPLACE_ALL=false
GO=false

function Ask {
    GO=true
    if test -e $1 ; then
        if ! $REPLACE_ALL ; then
            read -p "overwrite $1 [Y/n/a] ? " QUESTION
            case $QUESTION in
                Y|y|'')
                    ;;
                a)
                    REPLACE_ALL=true
                    ;;
                *)
                    GO=false
                    echo "skip $1" ;;
            esac
        fi
    else
        read -p "create $1 [Y/n] ? " QUESTION
        case $QUESTION in
            Y|y|'')
                ;;
            *)
                GO=false
                echo "skip $1" ;;
        esac
    fi
}

for FILE in * ; do
    SRC=`pwd`/$FILE
    LINK=$HOME/.$FILE

    case $FILE in
        $0|README)
            ;; # ignore
        terminator.config)
            LINK=$HOME/.config/terminator/config
            Ask $LINK
            if $GO ; then
                test -d `dirname $LINK` || mkdir `dirname $LINK`
                $GO && ln -svf $SRC $LINK
            fi
            ;;
        bin)
            LINK=$HOME/bin
            Ask $LINK
            $GO && ln -svf $SRC $LINK
            ;;
        *)
            Ask $LINK
            $GO && ln -svf $SRC $LINK
            ;;
    esac
done
