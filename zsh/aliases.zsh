function colours() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
  done
}

alias fliptable='echo "\n（╯°□°）╯︵ ┻━┻\n"'
alias ps='ps acx -o pid,command'
alias reload='source ~/.zshrc'
