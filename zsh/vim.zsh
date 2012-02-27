# Set editor
export EDITOR=vim

# To MacVim or Vim?
if [[ -x /usr/local/bin/mvim ]]; then
  if [[ $TERM = 'screen' ]]; then
    VIM='/usr/local/bin/mvim'
    VIMFLAGS='-v'
  else
    VIM='/usr/local/bin/mvim'
  fi
else
  VIM='vim'
fi
