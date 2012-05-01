alias reload='source ~/.zshrc'
alias ps='ps acx -o pid,command'
alias fliptable='echo "\n（╯°□°）╯︵ ┻━┻\n"'

function colours() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
  done
}
