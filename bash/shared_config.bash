# Source ~/.localrc if it exists
[[ -e $HOME/.localrc ]] && source $HOME/.localrc

export BROWSER=open
export DOTFILES=$HOME/.dotfiles
export GIT_SANDBOX=$PROJECTS/sandbox

# Path
export PATH=./bin
export PATH=$PATH:$DOTFILES/bin
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

# Editor
if [[ -f `which mvim` ]] ; then
  export VIM='mvim -v'
else
  export VIM=vim
fi
export EDITOR=$VIM
alias e=$EDITOR

# Git
[[ -f `which hub` ]] && alias git='hub'
alias g='git'

if [[ -f `which hitch` ]] ; then
  alias unhitch='hitch --unhitch'
  hitch() {
    command hitch "$@"
    if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
  }
fi

sandbox() {
  cd $GIT_SANDBOX && git clone $1 && cd `last_modified`
}

# Heroku
alias h='heroku'

# Ruby
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias f='foreman'
alias fr='foreman run'
alias r='rake'

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby 1.9.3

# System
function colours() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
  done
}
alias fliptable='echo （╯°□°）╯︵ ┻━┻'
alias ll='ls -al'
alias ssh_up='systemsetup -setremotelogin on'
alias ssh_down='systemsetup -setremotelogin off'

# Tmux
#alias tmux='tmux -2'
if [[ "$(uname)" = 'Darwin' ]]; then
  alias tmux='tmux -2 -f ~/.tmux-osx.conf'
else
  alias tmux='tmux -2'
fi
function mx() {
  if [[ -z $1 ]]; then
    SESSION=$(basename $PWD);
  else
    SESSION=$1
  fi

  if [[ -x $DOTFILES/tmux/workspaces/$SESSION ]]; then
    $DOTFILES/tmux/workspaces/$SESSION
  else
    if ! tmux has-session -t $SESSION; then
      tmux new-session -s $SESSION -n shell -d
    fi
    tmux attach -t $SESSION
  fi
}
