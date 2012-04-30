# Load tmuxinator
#[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
# Load tmuxifier
#export TMUXIFIER_LAYOUT_PATH="$DOTFILES/tmux/layouts"
#[[ -s "$HOME/.tmuxifier/init.sh" ]] && source "$HOME/.tmuxifier/init.sh"

function start() {
  if [[ -x $DOTFILES/tmux/layouts/$1 ]]; then
    $DOTFILES/tmux/layouts/$1
  else
    tmux new-session -s $1
  fi
}
