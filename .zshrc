#!/usr/bin/env zsh

# History
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt share_history

# Directories
setopt auto_cd
setopt auto_pushd
setopt pushdminus
unsetopt pushd_ignore_dups

# Completion
setopt always_to_end
setopt auto_menu
setopt complete_in_word
unsetopt flow_control
unsetopt menu_complete
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

setopt correct
setopt ignore_eof
setopt local_options
setopt local_traps
setopt no_bg_nice
setopt no_hup
setopt no_list_beep
setopt prompt_subst

autoload -U bashcompinit; bashcompinit
autoload -U compinit; compinit
autoload -U promptinit; promptinit
zmodload zsh/nearcolor

# zplug
if [[ -f "$(command -v brew)" ]]; then
  export ZPLUG_HOME=$(brew --prefix)/opt/zplug # homebrew-installed zplug
else
  export ZPLUG_HOME=/usr/local/opt/zplug
fi
source $ZPLUG_HOME/init.zsh
# Plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "mafredri/zsh-async", use:"async.zsh", hook-build:"ln -sf $ZPLUG_HOME/repos/mafredri/zsh-async/async.zsh $(brew --prefix)/share/zsh/site-functions/async"
zplug "denysdovhan/spaceship-prompt", use:"spaceship.zsh", from:github, as:theme, , hook-build:"ln -sf $ZPLUG_HOME/repos/denysdovhan/spaceship-prompt/spaceship.zsh $(brew --prefix)/share/zsh/site-functions/prompt_spaceship_setup"
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

# Prompt
prompt spaceship
# Spaceship
SPACESHIP_PACKAGE_SYMBOL=""
SPACESHIP_PROMPT_PREFIXES_SHOW=false
# SPACESHIP_PROMPT_SUFFIXES_SHOW=false
SPACESHIP_VI_MODE_INSERT=""
SPACESHIP_VI_MODE_NORMAL=""

# Source ~/.localrc if it exists
[[ -e "$HOME"/.localrc ]] && . "$HOME"/.localrc

# asdf
# For brew version:
# [[ -f "/usr/local/opt/asdf/asdf.sh" ]] && . /usr/local/opt/asdf/asdf.sh
# [[ -f "/usr/local/etc/bash_completion.d/asdf.bash" ]] && . /usr/local/etc/bash_completion.d/asdf.bash
# For manual install
[[ -f "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"
[[ -f "$HOME/.asdf/completions/asdf.bash" ]] && . "$HOME/.asdf/completions/asdf.bash"
[[ -f "$HOME/.asdf/plugins/java/set-java-home.zsh" ]] && . "$HOME/.asdf/plugins/java/set-java-home.zsh"

# Base16 Shell (doesn't work in Terminal.app)
if [[ "$TERM" =~ "256" ]] || [[ "$TERM" =~ "kitty" ]] || [[ "$TERM" =~ "screen" ]]; then
  BASE16_SHELL="$HOME/.config/base16-shell/"
  [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE16_SHELL"/profile_helper.sh)"
fi
# TODO: auto-switch base16 theme
# if [[ defaults read -g AppleInterfaceStyle =~ "Dark" ]] && [[ ]]


# Completions
for f in "$HOME/.config/bash/completions/"*; do
  . "$f"
done

# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
# ZSH_SYNTAX_HIGHLIGHT_PATH=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# [ -f $ZSH_SYNTAX_HIGHLIGHT_PATH ] && . $ZSH_SYNTAX_HIGHLIGHT_PATH

# Anybar
anybar() {
  if [[ "$1" = 'open' ]]; then
    open /Applications/AnyBar.app
  fi
  printf "%s" "${1:-white}" | nc -4u -w0 localhost "${2:-1738}"
}

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
# [[ -f "$(command -v hub)" ]] && eval "$(hub alias -s)" && alias g=hub
complete -o default -o nospace -F _git g
alias d='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
daa() {
  d add $(d s | grep -v master | awk '{printf "%s ", $2}')
}

# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

ghh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey 'g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r hh
unset -f bind-git-helper

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

# Node
[[ -f "$HOME/.asdf/asdf.sh" ]] && . "$HOME/.asdf/asdf.sh"
if [[ -f "$(command -v npm)" ]]; then
  export NODE_PATH=$(npm root --quiet -g)
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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

