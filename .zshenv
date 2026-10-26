#!/usr/bin/env zsh

[[ -f "$HOME/.localrc" ]] && . "$HOME/.localrc"

# PATH
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/.local/bin"
# Prepend so asdf beats system binaries (e.g. Debian's /usr/bin/python) in non-interactive shells too
export PATH="$HOME/.asdf/shims:$PATH"
# Bun
# Guarded: BUN_INSTALL is set later in .zshrc, so unset here would prepend "/bin"
[[ -n "$BUN_INSTALL" ]] && export PATH="$BUN_INSTALL/bin:$PATH"
# mkdir .git/safe for to add this to PATH
export PATH=".git/safe/../../bin:$PATH"
