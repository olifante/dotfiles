# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
		source "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "/Developer/usr/bin" ]; then
    PATH="/Developer/usr/bin:$PATH"
fi

if [ -d "$HOME/bin/Utilities" ]; then
    PATH="$HOME/bin/Utilities:$PATH"
fi

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "/usr/local/share/python" ]; then
    PATH="/usr/local/share/python:$PATH"
fi

if [ -d "/usr/local/bin" ]; then
    PATH="/usr/local/bin:$PATH"
fi

if [ -d "$HOME/narwhal/bin" ]; then
    PATH="$HOME/narwhal/bin":$PATH
fi
