#!/usr/bin/env zsh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS

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
[[ -e "$HOME"/.localrc ]] && . "$HOME"/.localrc

# Base16 Shell (doesn't work in Terminal.app)
if [[ "$TERM" =~ "256" ]] || [[ "$TERM" =~ "kitty" ]] || [[ "$TERM" =~ "screen" ]]; then
  BASE16_SHELL="$HOME/.config/base16-shell/"
  [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL"/profile_helper.sh)"
fi

# Autocomplete
autoload -U compinit; compinit

# Prompt
autoload -U promptinit; promptinit
zmodload zsh/nearcolor
prompt pure
zstyle :prompt:pure:prompt:error color red #'#dc322f'
zstyle :prompt:pure:prompt:success color green #'#859900'

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
ZSH_SYNTAX_HIGHLIGHT_PATH=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $ZSH_SYNTAX_HIGHLIGHT_PATH ] && . $ZSH_SYNTAX_HIGHLIGHT_PATH

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
[[ -f "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"
[[ -f "$HOME/.asdf/completions/asdf.bash" ]] && . "$HOME/.asdf/completions/asdf.bash"

# AWS
if [[ -s "$HOME"/.awsam/bash.rc ]]; then
  export AWS_DEFAULT_USER=ubuntu
  . "$HOME"/.awsam/bash.rc
fi
#ec2-find() {
#  aws ec2 describe-instances --filters Name=tag-value,Values=*$1* | grep "$1\|InstanceId" | uniq | sed -e 's/^[ \t\]*//' -e 's/,//g' | paste - -
#}

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
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh

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
alias reload='. $HOME/.zshrc'
alias sound='afplay /System/Library/Sounds/Glass.aiff'
alias ssh_up='systemsetup -setremotelogin on'
alias ssh_down='systemsetup -setremotelogin off'
source_invision() {
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
