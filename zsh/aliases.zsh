alias reload='source ~/.zshrc'

alias be='bundle exec'
alias bi='bundle install'

alias g='git'
alias ga='git add ./'
alias gb='git branch'
alias gc='git commit -a -v'
alias gco='git checkout'
alias gd='git pull'
alias gf='git fetch'
alias gfp='git fetch -p'
alias glola='git log --graph --decorate --pretty=oneline --abbrev-commit --all'
alias gs='git status'
alias gsub='git submodule'
alias gu='git push'

alias pc_precompile='be rake assets:precompile RAILS_ENV=development RAILS_ASSETS_NODIGEST=true'

alias vim='mvim'
alias mvim='mvim -v'

alias tmux='tmux -2'

alias pg-up='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'

alias nginx-up="sudo nginx -c /usr/local/etc/nginx/nginx.conf"
alias nginx-down="sudo nginx -s stop"

alias redis-up='redis-server /usr/local/etc/redis.conf > /dev/null &'
alias redis-down='killall redis-server'

alias ls='ls -al'

# Enable/disable remote login in OSX
alias rup='systemsetup -setremotelogin on'
alias rdown='systemsetup -setremotelogin off'

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
#if $(gls &>/dev/null)
#then
#  alias ls="gls -F --color"
#  alias l="gls -lAh --color"
#  alias ll="gls -l --color"
#  alias la='gls -A --color'
#fi
