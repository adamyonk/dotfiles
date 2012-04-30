# Set git editor
export GIT_EDITOR=vim
export GIT_SANDBOX=~/.code/sandbox

# Wrap git with hub
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

# Sandbox function (thanks @pengwynn!)
function sandbox() {
  cd $GIT_SANDBOX && git clone $1 && cd `last_modified`
}

# Load hitch
hitch() {
  command hitch "$@"
  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
}
alias unhitch='hitch -u'

alias g='git'
alias ga='git add .'
alias gb='git branch'
alias gc='git commit -a -v'
alias gco='git checkout'
alias gd='git pull'
alias gf='git fetch'
alias gfp='git fetch -p'
alias gh='git h'
alias glola='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gm='git merge'
alias gmm='git merge master'
alias gn='git n'
alias gs='git status -s -b'
alias gsub='git submodule'
alias gu='git push'
