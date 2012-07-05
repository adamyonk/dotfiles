# Check for brew and grc
grc_conf="`brew --prefix grc`/etc/grc.bashrc"
if [[ -f $grc_conf ]]; then
  source $grc_conf
  alias curl='colourify curl -s'
fi
