function mx() {
  if [[ -z $1 ]]; then
    SESSION=$(basename $PWD);
  else
    SESSION=$1
  fi

  if [[ -x $DOTFILES/tmux/layouts/$SESSION ]]; then
    $DOTFILES/tmux/layouts/$SESSION
  else
    #tmux new-session -s $1
    if ! tmux has-session -t $SESSION; then
      tmux new-session -s $SESSION -n zsh -d
    fi
    tmux attach -t $SESSION
  fi
}

alias tmux='tmux -2' # Force tmux to assume the terminal supports 256 colours
