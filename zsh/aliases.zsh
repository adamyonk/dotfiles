function colours() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
  done
}

alias fliptable='echo "\n（╯°□°）╯︵ ┻━┻\n"'
alias ps='ps acx -o pid,command'
alias reload='source ~/.zshrc'
alias rup='systemsetup -setremotelogin on'
alias rdown='systemsetup -setremotelogin off'
alias tmux='tmux -2'
alias vim='mvim -v'
alias e=$EDITOR
alias ls='ls -al'
