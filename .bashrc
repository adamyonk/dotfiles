#!/usr/bin/env bash
export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"

SOURCE="${BASH_SOURCE[0]}"
while [[ -h "$SOURCE" ]]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ "$SOURCE" != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
export dotfiles="${DIR%/bash*}"

export PATH=".git/safe/../../bin"
export PATH=".git/safe/../../script"
export PATH=".git/safe/../../scripts"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
# Go
export GOPATH=$HOME/Code/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
# Heroku
export PATH="$PATH:/usr/local/heroku/bin"
# Rust
export PATH="$PATH:/Users/adamyonk/.cargo/bin"

# Source ~/.localrc if it exists
# shellcheck source=/dev/null
[[ -e "$HOME"/.localrc ]] && . "$HOME"/.localrc

# Base16 Shell (doesn't work in Terminal.app)
if [[ "$TERM" =~ "256" ]] || [[ "$TERM" =~ "kitty" ]] || [[ "$TERM" =~ "screen" ]]; then
  BASE16_SHELL="$HOME/.config/base16-shell/"
  [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL"/profile_helper.sh)"
fi

# Anybar
anybar() {
  if [[ "$1" = 'open' ]]; then
    open /Applications/AnyBar.app
  fi
  printf "%s" "${1:-white}" | nc -4u -w0 localhost "${2:-1738}"
}

# asdf
# For brew version:
# [[ -f "/usr/local/opt/asdf/asdf.sh" ]] && . /usr/local/opt/asdf/asdf.sh
# [[ -f "/usr/local/etc/bash_completion.d/asdf.bash" ]] && . /usr/local/etc/bash_completion.d/asdf.bash
# For manual install
# shellcheck source=/dev/null
[[ -f "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"
# shellcheck source=/dev/null
[[ -f "$HOME/.asdf/completions/asdf.bash" ]] && . "$HOME/.asdf/completions/asdf.bash"

# AWS
if [[ -s "$HOME"/.awsam/bash.rc ]]; then
  export AWS_DEFAULT_USER=ubuntu
  # shellcheck source=/dev/null
  . "$HOME"/.awsam/bash.rc
fi
#ec2-find() {
#  aws ec2 describe-instances --filters Name=tag-value,Values=*$1* | grep "$1\|InstanceId" | uniq | sed -e 's/^[ \t\]*//' -e 's/,//g' | paste - -
#}

# Bash Sensible
# shellcheck source=./bash-sensible.bash
[[ -f "$HOME/.config/bash/bash-sensible.bash" ]] && . "$HOME/.config/bash/bash-sensible.bash"

# Browser
export BROWSER=open
alias chrome="/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"

# Colors
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
GRAY="$(tput setaf 8)"
BOLD="$(tput bold)"
UNDERLINE="$(tput sgr 0 1)"
INVERT="$(tput sgr 1 0)"
NOCOLOR="$(tput sgr0)"
export RED
export GREEN
export YELLOW
export BLUE
export MAGENTA
export CYAN
export WHITE
export GRAY
export BOLD
export UNDERLINE
export INVERT
export NOCOLOR

# Completions
# shellcheck source=/dev/null
[[ -f /usr/local/share/bash-completion/bash_completion ]] && . /usr/local/share/bash-completion/bash_completion
# shellcheck source=/dev/null
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# cowsay
export COWPATH="$dotfiles/system/cows/:/usr/local/Cellar/cowsay/3.04/share/cows/"
alias bunny="cowsay -W 15 -f signbunny"

# ctop
alias ctop="TERM=xterm256-color ctop"

# Editor
if [[ -f "$(command -v nvim)" ]]; then
  export EDITOR='nvim'
elif [[ -f "$(command -v vim)" ]]; then
  export EDITOR='vim'
else
  export EDITOR='vi'
fi
alias e="\$EDITOR"

# FZF
export FZF_DEFAULT_COMMAND='ag -g "" --hidden'
# shellcheck source=/dev/null
[[ -f "$HOME/.fzf.bash" ]] && . "$HOME/.fzf.bash"

# Git
alias g=git
[[ -f "$(command -v hub)" ]] && eval "$(hub alias -s)" && alias g=hub
complete -o default -o nospace -F _git g
alias d='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# GnuPG
GPG_TTY="$(tty)"
export GPG_TTY

# GPGTools
# export GPG_TTY=$(tty)
# export PINENTRY_USER_DATA="USE_CURSES=1"

# if [[ -n "$SSH_CONNECTION" ]]; then
#   export PINENTRY_USER_DATA="USE_CURSES=1"
# fi

# Go

# gotop
alias gotop="TERM=xterm256-color gotop"

# Heroku
alias h='heroku'

# Homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
if [[ "$(uname -s)" == "Linux" ]]; then
  if [[ -d ~/.linuxbrew ]]; then
    eval $(~/.linuxbrew/bin/brew shellenv)
  elif [[ -d /home/linuxbrew/.linuxbrew ]]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  fi
fi

# Ruby
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias f='foreman'
alias fb='foreman run bundle exec'
alias fr='foreman run'
alias fs='foreman start'
alias r='rake'

# Rust

# System
colours() {
  for i in {0..255}; do
    printf "%s" "\\x1b[38;5;${i}m${i} "
  done
  unset i
}
fixaudio() {
  sudo killall coreaudiod
}
fixbluetooth() {
  sudo killall bluetoothd
}
fixcamera() {
  sudo killall VDCAssistant
}
proxy() {
  if [[ "$1" ]]; then
    # For socks5
    # networksetup -setsocksfirewallproxystate Wi-Fi "$1"
    networksetup -setsecurewebproxystate Wi-Fi "$1"
    networksetup -setwebproxystate Wi-Fi "$1"
  fi

  local status="$(networksetup -getsecurewebproxy Wi-Fi | grep ^Enabled | cut -f 2 -d ' ')"
  if [[ "$status" =~ 'no' ]]; then
    anybar black
  else
    anybar white
  fi
  echo "$status"
}
publicip() {
  curl https://api.ipify.org
}
alias c='caffeinate -d'
alias cta='caffeinate -d tmux at'
alias fliptable='echo （╯°□°）╯︵ ┻━┻'
alias lc='launchctl'
alias ll='ls -al'
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias reload='. $HOME/.bashrc'
alias sound='afplay /System/Library/Sounds/Glass.aiff'
alias ssh_up='systemsetup -setremotelogin on'
alias ssh_down='systemsetup -setremotelogin off'
source_invision() {
  # shellcheck source=/dev/null
  . ~/Code/InVision_Docker/scripts-native/invision.sh
}

# Tmux
alias tmux='tmux -2'
if [[ -n "$TMUX" ]]; then
  refresh() {
    export "$(tmux show-environment | grep '^SSH_AUTH_SOCK')"
  }
else
  refresh() { exit 1; }
fi

# Vagrant
alias v='vagrant'

# Yarn
alias y='yarn'

# shellcheck source=./prompt.bash
. "$HOME/.config/bash/prompt.bash"
for f in "$HOME/.config/bash/completions/"*; do
  # shellcheck source=/dev/null
  . "$f"
done
for f in "/usr/local/etc/bash_completion.d/"*; do
  # shellcheck source=/dev/null
  . "$f"
done

# shellcheck source=/dev/null
[[ -f ~/.fzf.bash ]] && . ~/.fzf.bash

# export NVM_DIR="$HOME/.nvm"
# # shellcheck source=/dev/null
# [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# # shellcheck source=/dev/null
# [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# added by travis gem
[ -f /Users/adam/.travis/travis.sh ] && source /Users/adam/.travis/travis.sh
