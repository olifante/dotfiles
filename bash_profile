echo "sourcing bash profile"

append_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

prepend_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

prepend_to_path /usr/local/bin
prepend_to_path /usr/bin
prepend_to_path /bin
prepend_to_path /usr/local/sbin
prepend_to_path /usr/sbin
prepend_to_path /sbin

append_to_path /usr/local/mysql/bin
append_to_path /usr/local/opt/go/libexec/bin
append_to_path /usr/local/share/npm/bin
append_to_path /usr/share/maven/bin
append_to_path "$HOME/bin"
append_to_path "$HOME/.local/bin"
append_to_path "$HOME/.cabal/bin"
append_to_path "$HOME/go/bin"
append_to_path "$HOME/narwhal/bin"

export PATH

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/

# source /usr/local/bin/virtualenvwrapper.sh

if which rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# Load user profile file
if [ -f ~/.profile ]; then
    source ~/.profile
fi

export PATH="$HOME/.cargo/bin:$PATH"
