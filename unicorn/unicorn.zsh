# Load unicorn
function bbu() {
  if [[ -z $1 ]]; then
    UNICORN_PORT=3000;
  else
    UNICORN_PORT=$1;
  fi
  bin/unicorn -E development -c /usr/local/etc/unicorn.rb -1 127.0.0.1:$UNICORN_PORT
}
