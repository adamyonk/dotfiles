# Check for brew and grc
if [[ -f `command -v brew` ]]; then
  grc_conf="`brew --prefix grc`/etc/grc.bashrc"
  if [[ -f $grc_conf ]]; then
    source $grc_conf
    alias curl='colourify curl -s'
  fi
fi
