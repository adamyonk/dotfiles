# Prompt
color_green=$'\033[0;32m'
color_red=$'\033[0;31m'
color_none=$'\033[0m'

# Last status
prompt_status() {
  status="$?"
  if [ "$status" == 0 ]; then
    printf "$color_green"
  else
    printf "$color_red"
  fi
  printf '✖'
  printf "$color_none"
}

# Working directory
prompt_dir() {
  printf "${PWD##*/}"
}

# Git info
prompt_git() {
  if git status >/dev/null 2>&1; then
    if git diff --quiet HEAD 2>&1; then
      local color="$color_green"
    else
      local color="$color_red"
    fi
    printf " [$color$(git branch | awk '/*/ {print $2}')$color_none]"
  fi
}

# Prompt char for user or root
prompt_char() {
  local char=➔
  [ "$UID" == 0 ] && char=\$
  printf "$char"
}

PS1='\[\033[G\] $(prompt_status) $(prompt_dir)$(prompt_git) $(prompt_char) '
