# ~/.bashrc: executed by bash(1) for non-login shells.
## see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
## for examples

## If not running interactively, don't do anything
if [[ -n "$PS1" ]] ; then
    ## append to the history file, don't overwrite it
    shopt -s histappend

    ## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

    ## check the window size after each command and, if necessary,
    ## update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    shopt -s cdspell
    shopt -s cmdhist
    shopt -s extglob
    shopt -s no_empty_cmd_completion
    shopt -s progcomp
    shopt -s hostcomplete
    shopt -s interactive_comments
    shopt -s promptvars

    export LESS="--quit-at-eof --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --squeeze-blank-lines"
    export PAGER=less

    hash ssh-agent &> /dev/null
    if [ $? -eq 0 ]; then
        #; Setup the SSH auth socket for the SSH agent.
        SSHDIR="${HOME}/.ssh"
        SSH_AUTH_SOCK="${SSHDIR}/.ssh-agent-socket"
        export SSHDIR SSH_AUTH_SOCK

        if [ ! -S "$SSH_AUTH_SOCK" ]; then
            ssh-agent -a "$SSH_AUTH_SOCK"
            ssh-add
        fi
    fi

    sscreen () {
        ssh -t "${1}" /usr/bin/screen -xRR
    }

    sshmux () {
        ssh "$@" -t 'tmux a || tmux || /bin/bash'
    }

    ## ignore ls, bg, fg, exit commands
    export HISTIGNORE="ls:[bf]g:exit"

    ## don't put duplicate lines in the history. See bash(1) for more options
    ## don't overwrite GNU Midnight Commander's setting of `ignorespace'.
    HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
    ## ... or force ignoredups and ignorespace
    HISTCONTROL=ignoreboth

    ## make less more friendly for non-text input files, see lesspipe(1)
    if [ -x /usr/bin/lesspipe ]; then
        eval "$(SHELL=/bin/sh lesspipe)"
    fi

    GIT_COMPLETION="$HOME/bin/git-completion.bash"
    if [[ -s "$GIT_COMPLETION" ]]; then
        source "$GIT_COMPLETION"
    fi

    ## If you often cd into large repos, the following flags might slow you down.
    ## Uncomment these lines if you don't usually work with huge git repos
    # GIT_PS1_SHOWDIRTYSTATE=true # Add Git dirty state mark to PS1
    # GIT_PS1_SHOWSTASHSTATE=true # Show if something is stashed
    # GIT_PS1_SHOWUNTRACKEDFILES=true # Show if there're untracked files

    # hash returns 1 if command not found
    hash git &> /dev/null
    if [ $? -eq 0 ]; then
        ## git found
        hash __git_ps1 &> /dev/null
        if [ $? -eq 0 ]; then
            export PROMPT_COMMAND='GIT=$(__git_ps1 " (%s)")'
        fi
        export GIT_BRANCH='$(echo $GIT)'
        ## Are dotfiles clean?
        "$HOME/bin/dotfiles"
    else
        ## git not found
        export PROMPT_COMMAND=""
        export GIT_BRANCH=""
    fi

    function set_prompt {

        case $TERM in
          xterm*)
          local TITLEBAR='\[\033]0;\w\007\]'
          ;;
          *)
          local TITLEBAR=""
          ;;
        esac

        ## set it to 'yes' if you want colored prompt
        color_prompt=yes

        if [ "$color_prompt" = yes ]; then
            # Colors ('[1;' for bold and '[0;' for non-bold)
            local          RED="\[\e[0;31m\]"
            local        GREEN="\[\e[0;32m\]"
            local       YELLOW="\[\e[0;33m\]"
            local         BLUE="\[\e[0;34m\]"
            local       PURPLE="\[\e[0;35m\]"
            local         CYAN="\[\e[0;36m\]"
            local   LIGHT_GRAY="\[\e[0;37m\]"
            local    LIGHT_RED="\[\e[1;31m\]"
            local  LIGHT_GREEN="\[\e[1;32m\]"
            local LIGHT_YELLOW="\[\e[1;33m\]"
            local   LIGHT_BLUE="\[\e[1;34m\]"
            local LIGHT_PURPLE="\[\e[1;35m\]"
            local   LIGHT_CYAN="\[\e[1;36m\]"
            local        WHITE="\[\e[1;37m\]"
            local    COLOR_OFF="\[\e[0m\]"
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
\`if [ \$? = 0 ]; then echo \[\e[37m\]^_^ \$?\[\e[0m\]; else echo \[\e[31m\]O_O\ \$?\[\e[0m\]; fi\` \
${CYAN}\
\D{%H:%M} \
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

    ## enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        if [ -r "$HOME/.dircolors" ]; then
            eval "$(dircolors -b $HOME/.dircolors)"
        else
            eval "$(dircolors -b)"
        fi
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    ## Alias definitions.
    ## You may want to put all your additions into a separate file like
    ## ~/.bash_aliases, instead of adding them here directly.
    ## See /usr/share/doc/bash-doc/examples in the bash-doc package.
    BASH_ALIASES="$HOME/.bash_aliases"
    if [ -f "$BASH_ALIASES" ]; then
        source "$BASH_ALIASES"
    fi

    ## This is a good place to source rvm v v v (loads RVM into a shell session).
    RVM="$HOME/.rvm/scripts/rvm"
    if [[ -s "$RVM" ]]; then
        source "$RVM"
    fi

    ## Set TERM for 256color support (install ncurses-term is a plus)
    export TERM='gnome-256color'

    ## Define virtualenv variables
    export WORKON_HOME=$HOME/.virtualenvs
    VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper.sh"
    if [[ -s "$VIRTUALENVWRAPPER" ]]; then
        source "$VIRTUALENVWRAPPER"
    fi

    ## Point to Java files
    export JAVA_HOME=$(/usr/libexec/java_home)
    # export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
    # export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home

    ## Add classpath for Clojure
    export CLASSPATH=$CLASSPATH:"/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar"

    export PYTHONSTARTUP=$HOME/.pythonrc.py

    ## Define variables for Cappuccino development
    export NARWHAL_ENGINE=jsc
    export CAPP_BUILD="$HOME/git/cappuccino/Build"

    ## Load git token
    GITHUBCONFIG="$HOME/.githubconfig.sh"
    if [ -x "$GITHUBCONFIG" ]; then
        source "$GITHUBCONFIG"
    fi

    ## If brew found
    hash brew &> /dev/null
    if [ $? -eq 0 ]; then
        ## Load z, a smart cd that learns your favorite directories
        Z_SCRIPT=$(brew --prefix)/etc/profile.d/z.sh
        if [ -x "$Z_SCRIPT" ]; then
            ## install with "brew install z"
            source "$Z_SCRIPT"
        fi
        ## Load programmable bash completion
        BASH_COMPLETION=$(brew --prefix)/etc/bash_completion
        if [ -f "$BASH_COMPLETION" ] && ! shopt -oq posix; then
            ## install with "brew install bash_completion"
            source "$BASH_COMPLETION"
        fi
    fi

    ## Use vim instead of vi if available
    hash vim &> /dev/null
    if [ $? -eq 0 ]; then
        alias vi=vim
    fi

    ## Use vi keybindings for command-line editing
    set -o vi

    ## Set the EDITOR variable
    SUBLIME_SHORTCUT="$HOME/dotfiles/bin/subl"
    if [ -x "$SUBLIME_SHORTCUT" ]; then
        export EDITOR=subl
        alias sd='subl .'
    else
        export EDITOR=vi
    fi

fi # end of 'if [[ -n "$PS1" ]] ; then'

ANDROID_HOME=/Users/the/frameworks/android-sdk-max_x86
export ANDROID_HOME

export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=$WORKON_HOME

use_env() {
  typeset venv
  venv="$1"
  if [[ $(basename "${VIRTUAL_ENV:t}") != "$venv" ]]; then
    if workon | grep "$venv" > /dev/null; then
      workon "$venv"
    else
      echo -n "Create virtualenv $venv now? (Yn) "
      read answer
      if [[ "$answer" == "Y" ]]; then
        mkvirtualenv "$venv"
      fi
    fi
  fi
}

source /usr/local/Cellar/autoenv/0.1.0/activate.sh
export AWS_RDS_HOME=/Users/the/bin/rds/RDSCli-1.15.001
export EC2_HOME=/Users/the/bin/ec2/ec2-api-tools-1.6.13.0
export EC2_REGION=eu-west-1
export EC2_PRIVATE_KEY=$HOME/.ssh/s2m.pem
export EC2_CERT=$HOME/.ssh/
