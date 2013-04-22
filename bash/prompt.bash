# Prompt
color_green=$'\033[0;32m'
color_red=$'\033[0;31m'
color_none=$'\033[0m'

prompt_dir() {
  #echo -n ${PWD/#$HOME/~}
  echo -n "$(basename $(echo $PWD | sed -e "s|^$HOME|~|"))"
}

prompt_git_info() {
  if git status >/dev/null 2>&1; then
    if git diff --quiet HEAD; then
      color=$color_green
    else
      color=$color_red
    fi
    echo -n "[$color$(git branch | awk '/*/ {print $2}')$color_none]"
  else
    echo -n ''
  fi
}

prompt() {
  echo -n "\$(prompt_dir) ✖$color_none  "
}

export PS1=$(eval prompt)
