#! /usr/bin/env sh
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

echo "sourcing sh profile"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/usr/local/sbin" ]; then
    PATH="/usr/local/sbin:$PATH"
fi

if [ -d "/usr/local/share/npm/bin" ]; then
    PATH="/usr/local/share/npm/bin:$PATH"
fi

if [ -d "$HOME/go/bin" ]; then
    PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/narwhal/bin" ]; then
    PATH="$HOME/narwhal/bin:$PATH"
fi

if [ -d "/usr/local/share/npm/bin" ]; then
    PATH="/usr/local/share/npm/bin:$PATH"
fi

if [ -d "/usr/share/maven/bin" ]; then
    PATH="/usr/share/maven/bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
    PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.cabal/bin" ]; then
    PATH="$PATH:$HOME/.cabal/bin"
fi

if [ -d "/usr/local/opt/go/libexec/bin" ]; then
    PATH="$PATH:/usr/local/opt/go/libexec/bin"
fi

if [ -d "/Applications/Postgres.app/Contents/Versions/10/bin" ]; then
    PATH=$PATH:/Applications/Postgres.app/Contents/Versions/10/bin
fi

export PATH

set -o vi
