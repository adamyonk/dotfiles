# Load rbenv
eval "$(rbenv init -)"

# Load unicorn
function bbu() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  bin/unicorn -E development -c /usr/local/etc/unicorn.rb -1 127.0.0.1:$UNICORN_PORT
}

alias pc_precompile='bundle exec rake assets:precompile RAILS_ENV=development RAILS_ASSETS_NODIGEST=true'

alias bundle='nocorrect bundle'
alias be='bundle exec'
alias bi='bundle install'

alias killall=eval "kill -QUIT $(ps aux | grep "postgres\|redis\|mailcatcher\|sphinx\|unicorn" | awk '{print $2}' | xargs)"

alias pg-up='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log'
alias nginx-up="sudo nginx -c /usr/local/etc/nginx/nginx.conf"
alias nginx-down="sudo nginx -s stop"
alias redis-up='redis-server /usr/local/etc/redis.conf > /dev/null &'
alias redis-down='killall redis-server'
