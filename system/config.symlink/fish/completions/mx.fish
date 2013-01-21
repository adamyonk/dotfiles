set -l arguments (ls $DOTFILES/tmux/layouts/)

complete --arguments "$arguments" --command mx --no-files
