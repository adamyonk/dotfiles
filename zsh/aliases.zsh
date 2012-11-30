function colours() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
  done
}

alias fliptable='echo "\n（╯°□°）╯︵ ┻━┻\n"'
alias ls='ls -al' # Include dot files, list in long format
#alias minecraft='cd ~/.minecraft && java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui'
alias minecraft='cd ~/.minecraft && java -jar minecraft_server.jar nogui'
alias ps='ps -a -c -o pid,command -x' # All users processes, only executable name, custom output, show processes with no controlling terminal
alias reload='source ~/.zshrc'
alias ssh_up='systemsetup -setremotelogin on'
alias ssh_down='systemsetup -setremotelogin off'
