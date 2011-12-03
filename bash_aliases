# General aliases

case $OSTYPE in
    linux*)
        alias l='/bin/ls -color'
        ;;
    darwin*)
        alias l='/bin/ls -G'
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
