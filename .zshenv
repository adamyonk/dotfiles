#!/usr/bin/env zsh

[[ -f "$HOME/.localrc" ]] && . "$HOME/.localrc"

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
# Java
[[ -f "$HOME/.asdf/plugins/java/set-java-home" ]] && . "$HOME/.asdf/plugins/java/set-java-home"
# Rust
export PATH="$PATH:$HOME/.cargo/bin"
[[ -f "$HOME/.asdf/installs/rust/1.65.0/env" ]] && . "$HOME/.asdf/installs/rust/1.65.0/env"
# Python
# export PATH="$PATH:/usr/local/lib/python3.9/site-packages"
# export PATH="$PATH:/Users/adam/Library/Python/3.9/bin"

# ASDF
[[ -f "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"
eval "$(/opt/homebrew/bin/brew shellenv)"
