# Set git editor
export GIT_SANDBOX=$PROJECTS/sandbox

# Wrap git with hub
if [[ -f `command -v hub` ]] ; then alias git='hub' ; fi

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
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbr='git browse'
alias gc='git commit --all --verbose'
alias gca='git commit --amend'
alias gcl='git clone'
alias gco='git checkout'
alias gcot='git checkout --track'
alias gcp='git cherry-pick'
alias gd='git diff'
alias dlc='diff --cached HEAD^'
alias gf='git fetch'
alias gfl='git log -u'
alias gfp='git fetch --prune'
alias gl='git log --decorate'
alias gla='git log --abbrev-commit --all --decorate --graph --pretty=oneline'
alias glf='git log --decorate --numstat --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]"'
alias gm='git merge'
alias gmm='git merge master'
alias gn='git n'
alias gpl='git pull'
alias gpr='git pull-request'
alias gps='git push'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gre='git reset'
alias gri='git rebase --interactive'
alias gs='git status --branch --short'
alias gst='git stash'
alias gsta='git stash apply'
alias gstl='git stash list'
alias gsts='git stash save'
alias gsub='git submodule'
alias gsy='git pull && git push'
