# Load rbenv
#eval "$(rbenv init -)"

# Load chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Load unicorn
#function bbu() {
#  if [[ -z $1 ]]; then
#    UNICORN_PORT=3000;
#  else
#    UNICORN_PORT=$1;
#  fi
#  bin/unicorn -E development -c /usr/local/etc/unicorn.rb -1 127.0.0.1:$UNICORN_PORT
#}

alias rake='noglob rake'
alias bundle='noglob bundle'
alias be='bundle exec'
alias bi='bundle install'
alias fr='bundle exec foreman run bundle exec'

#alias killall=exec "kill -QUIT $(ps aux | grep "postgres\|redis\|mailcatcher\|sphinx\|unicorn" | awk '{print $2}' | xargs)"

# This might not be good to have on non-dev machines
#export RUBY_HEAP_MIN_SLOTS=1000000
#export RUBY_HEAP_SLOTS_INCREMENT=1000000
#export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
#export RUBY_GC_MALLOC_LIMIT=1000000000
#export RUBY_HEAP_FREE_MIN=500000

alias pg-up='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'
alias nginx-up="sudo nginx -c /usr/local/etc/nginx/nginx.conf"
alias nginx-down="sudo nginx -s stop"
alias redis-up='redis-server /usr/local/etc/redis.conf > /dev/null &'
alias redis-down='killall redis-server'
alias pc_precompile='bundle exec rake assets:precompile RAILS_ENV=development RAILS_ASSETS_NODIGEST=true'
