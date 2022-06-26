#!/usr/bin/env zsh

# PATH
export PATH=".git/safe/../../bin"
export PATH=".git/safe/../../script"
export PATH=".git/safe/../../scripts"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
# Go
export GOPATH=$projects/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
# Heroku
export PATH="$PATH:/usr/local/heroku/bin"
# Rust
export PATH="$PATH:/Users/adamyonk/.cargo/bin"
# Rust cargo bin
source ~/.asdf/installs/rust/1.60.0/env
# Python
export PATH="$PATH:/usr/local/lib/python3.9/site-packages"
export PATH="$PATH:/Users/adam/Library/Python/3.9/bin"


# ASDF
[[ -f "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"
