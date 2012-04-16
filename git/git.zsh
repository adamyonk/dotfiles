# Set git editor
export GIT_EDITOR=vim
# Wrap git with hub
function git(){hub "$@"}
