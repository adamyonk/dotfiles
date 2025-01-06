#!/usr/bin/env zsh

[[ -f "$HOME/.localrc" ]] && . "$HOME/.localrc"

# PATH
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"
# Bun
export PATH="$BUN_INSTALL/bin:$PATH"
# Go
export GOPATH=$projects/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
# Heroku
export PATH="$PATH:/usr/local/heroku/bin"
# Java
# [[ -f "$HOME/.asdf/plugins/java/set-java-home" ]] && . "$HOME/.asdf/plugins/java/set-java-home"
# Ruby
export ASDF_RUBY_BUILD_VERSION=master
# Rust
export PATH="$PATH:$HOME/.cargo/bin"
[[ -f "$HOME/.asdf/installs/rust/1.82.0/env" ]] && . "$HOME/.asdf/installs/rust/1.82.0/env"
# mkdir .git/safe for to add this to PATH
export PATH=".git/safe/../../bin:$PATH"
