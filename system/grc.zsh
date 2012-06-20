# Check for brew and grc
if [[ -f `command -v brew` ]]
then
  grc_path=$(brew --prefix grc)
  if [[ -f $grc_path ]]
  then
    source $grc_path/etc/grc.bashrc
  fi
fi
