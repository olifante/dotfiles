#! /usr/bin/env bash
# General aliases

case $OSTYPE in
    linux*)
        alias l='ls --color'
        ;;
    darwin*)
        alias l='ls -G'
        alias plxml=' plutil -convert xml1 -o -'
        alias pljson=' plutil -convert json -o -'
        alias flep='pgrep -ifl'
        ;;
    freebsd*)
        alias l='ls -G'
        ;;
    solaris*)
        if [[ -x /usr/local/bin/ls ]]; then
            echo using /usr/local/bin/ls --color
            alias lc='/usr/local/bin/ls --color'
        else alias l=ls
        fi
        ;;
    cygwin*)
        alias l='ls --color'
        ;;
    *)
        alias l=ls
        ;;
esac

# ls aliases
alias ll='l -l'
alias lt='l -rt'
alias la='l -A'
alias llt='l -lrt'
alias lla='l -lA'
alias llat='l -lArt'

# safe file operations
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# human-readable 'df' and 'du'
alias df='df -h'
alias du='du -h'

# other
alias timestamp='date "+%Y-%m-%d_%H:%M:%S"'
alias h='history'

alias ri='ri -Tf ansi'

alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'
alias .....='cd ..; cd ..; cd ..; cd ..'

# Misc
alias g='grep -i'  # Case insensitive grep
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'
alias m='more'
alias ssh-fingerprint='ssh-keygen -l -f'

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

# Python
alias pygcat="pygmentize -f terminal256 -O style=native -g"
alias dj="django-admin.py"
alias djp="django-admin.py --pythonpath=$(pwd)"
alias djs="django-admin.py --settings"
alias djps="django-admin.py --pythonpath=$(pwd) --settings"

# Xcode
alias swift='/Applications/Xcode6-Beta6.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift'
alias use_xcode5="sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer"
alias use_xcode6="sudo xcode-select -switch /Applications/Xcode6-Beta6.app/Contents/Developer"
