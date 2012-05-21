function mx() {
  if [[ -x $DOTFILES/tmux/layouts/$1 ]]; then
    $DOTFILES/tmux/layouts/$1
  else
    tmux new-session -s $1
  fi
}

alias tmux='tmux -2' # Force tmux to assume the terminal supports 256 colours
