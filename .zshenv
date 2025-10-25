#!/usr/bin/env zsh

[[ -f "$HOME/.localrc" ]] && . "$HOME/.localrc"

# PATH
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.asdf/shims"
# Bun
export PATH="$BUN_INSTALL/bin:$PATH"
# mkdir .git/safe for to add this to PATH
export PATH=".git/safe/../../bin:$PATH"
