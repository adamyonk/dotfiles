# Set git editor
export GIT_SANDBOX=~/.code/sandbox

# Wrap git with hub
if [[ -f `command -v hub` ]] ; then alias git=hub ; fi

# sandbox user/repo
function sandbox() {
  cd $GIT_SANDBOX && git clone $1 && cd `last_modified`
}

# Load hitch
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch --unhitch'

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbr='git browse'
alias gc='git commit --all --verbose'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcot='git checkout --track'
alias gd='git diff'
alias gf='git fetch'
alias gfp='git fetch --prune'
alias glola='git log --abbrev-commit --all --decorate --graph --pretty=oneline'
alias gm='git merge'
alias gmm='git merge master'
alias gn='git n'
alias gpl='git pull'
alias gpr='git pull-request'
alias gps='git push'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gre='git reset --hard HEAD'
alias gri='git rebase --interactive'
alias gs='git status --branch --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gsub='git submodule'
