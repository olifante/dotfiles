# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [[ -n "$PS1" ]] ; then

    # ignore ls, bg, fg, exit commands
    export HISTIGNORE="ls:[bf]g:exit"

    # don't put duplicate lines in the history. See bash(1) for more options
    # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
    HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
    # ... or force ignoredups and ignorespace
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # Customize PS1 with Git routines
    GIT_PS1_SHOWDIRTYSTATE=true # Add Git dirty state mark to PS1
    GIT_PS1_SHOWSTASHSTATE=true # Show if something is stashed
    GIT_PS1_SHOWUNTRACKEDFILES=true # Show if there're untracked files
    export GIT_AUTHOR_NAME="Tiago Henriques"
    export GIT_AUTHOR_EMAIL="trinosauro@gmail.com"
    # export GIT_COMMITTER_NAME="Tiago Henriques"
    # export GIT_COMMITTER_EMAIL="trinosauro@gmail.com"

    export PROMPT_COMMAND='GIT=$(__git_ps1 " (%s)")'
    export GIT_BRANCH='$(echo $GIT)'
    function set_prompt {

        case $TERM in
          xterm*)
          local TITLEBAR='\[\033]0;\w\007\]'
          ;;
          *)
          local TITLEBAR=""
          ;;
        esac

        # set it to 'yes' if you want colored prompt
        color_prompt=yes

        if [ "$color_prompt" = yes ]; then
            # Colors ('[1;' for bold and '[0;' for non-bold)
            local          RED="\[\033[0;31m\]"
            local        GREEN="\[\033[0;32m\]"
            local       YELLOW="\[\033[0;33m\]"
            local         BLUE="\[\033[0;34m\]"
            local       PURPLE="\[\033[0;35m\]"
            local         CYAN="\[\033[0;36m\]"
            local   LIGHT_GRAY="\[\033[0;37m\]"
            local    LIGHT_RED="\[\033[1;31m\]"
            local  LIGHT_GREEN="\[\033[1;32m\]"
            local LIGHT_YELLOW="\[\033[1;33m\]"
            local   LIGHT_BLUE="\[\033[1;34m\]"
            local LIGHT_PURPLE="\[\033[0;35m\]"
            local   LIGHT_CYAN="\[\033[0;36m\]"
            local        WHITE="\[\033[1;37m\]"
            local    COLOR_OFF="\[\033[0m\]"
        else
            local          RED=""
            local        GREEN=""
            local       YELLOW=""
            local         BLUE=""
            local       PURPLE=""
            local         CYAN=""
            local   LIGHT_GRAY=""
            local    LIGHT_RED=""
            local  LIGHT_GREEN=""
            local LIGHT_YELLOW=""
            local   LIGHT_BLUE=""
            local LIGHT_PURPLE=""
            local   LIGHT_CYAN=""
            local        WHITE=""
            local    COLOR_OFF=""
        fi

        PS1="
${TITLEBAR}\
${COLOR_OFF}\
\$ \
$(echo \$?) \
${LIGHT_GRAY}\
\D{%Y-%m-%d %H:%M} \
\u@\
\h:\
${BLUE}\
\w \
${GREEN}\
${GIT_BRANCH}
${COLOR_OFF}\
\$ "

        unset color_prompt
    }
    set_prompt

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        #alias dir='dir --color=auto'
        #alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi

    if [[ -s "$HOME/bin/git-completion.sh" ]]; then
        source "$HOME/bin/git-completion.sh"
    fi

fi # end of 'if [[ -n "$PS1" ]] ; then'

# This is a good place to source rvm v v v (loads RVM into a shell session).
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Set the EDITOR variable
export EDITOR='vim'

# Set TERM for 256color support (install ncurses-term is a plus)
export TERM='gnome-256color'

# Are dotfiles clean?
if [ -x git ]; then
    $HOME/bin/dotfiles
fi

# Load git token
if [ -x $HOME/.githubconfig.sh ]; then
    . $HOME/.githubconfig.sh
fi

# Load z, a smart cd that learns your favorite directories
if [ -x brew ]; then
    . `brew --prefix`/etc/profile.d/z.sh
fi

# Turn on the Bash vi mode. Mouahahaha!
set -o vi
