# Prompt
color_green=$'\033[0;32m'
color_red=$'\033[0;31m'
color_none=$'\033[0m'

# Last status
_prompt_status() {
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
_prompt_dir() {
  printf "${PWD##*/}"
}

# Git info
_prompt_git() {
  if git status >/dev/null 2>&1; then
    if git diff --quiet HEAD 2>&1; then
      local color="$color_green"
    else
      local color="$color_red"
    fi
    printf " $color$(git branch | awk '/*/ {print $2}')$color_none"
  fi
}

# Prompt char for user or root
_prompt_char() {
  local char=➔
  [ "$UID" == 0 ] && char=\$
  printf "$char"
}

PS1='\[\033[G\] $(_prompt_status) $(_prompt_dir)\n $(_prompt_char) '

# Prompt command
prompt_command() {
  # Only run this if we have a .git directory
  [[ -d .git ]] &&
  # If we just ran `git status`, don't run it again
  [[ `history 1` != *'g s'* ]] &&
  # Don't show every untracked file in a directory
  git status --branch --short --untracked=normal
}

# chruby needs prompt command for auto.sh to work
#PROMPT_COMMAND='prompt_command'
