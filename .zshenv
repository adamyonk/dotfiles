#!/usr/bin/env zsh

# PATH
export PATH=".git/safe/../../bin"
export PATH=".git/safe/../../script"
export PATH=".git/safe/../../scripts"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
# Go
export GOPATH=$HOME/Code/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
# Heroku
export PATH="$PATH:/usr/local/heroku/bin"
# Rust
export PATH="$PATH:/Users/adamyonk/.cargo/bin"
