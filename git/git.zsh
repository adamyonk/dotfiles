# Set git editor
export GIT_EDITOR=vim

# Wrap git with hub
function git(){hub "$@"}

# Load hitch
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}

alias g='git'
alias ga='git add .'
alias gb='git branch'
alias gc='git commit -a -v'
alias gco='git checkout'
alias gd='git pull'
alias gf='git fetch'
alias gfp='git fetch -p'
alias glola='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gn='git n'
alias gs='git status -s -b'
alias gsub='git submodule'
alias gu='git push'
