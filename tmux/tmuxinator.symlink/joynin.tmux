#!/bin/zsh
tmux start-server

if ! $(tmux has-session -t 'joynin'); then
cd ~/Code/elevate/joynin
rvm use 1.9.2@global
env TMUX= tmux start-server \; set-option -g base-index 1 \; new-session -d -s 'joynin' -n 'editor'
tmux set-option -t 'joynin' default-path ~/Code/elevate/joynin


tmux new-window -t 'joynin':2 -n 'assets'


# set up tabs and panes

# tab "editor"

tmux send-keys -t 'joynin':1 'rvm use 1.9.2@global && vim' C-m


# tab "assets"

tmux send-keys -t 'joynin':2 'rvm use 1.9.2@global && git pull origin develop' C-m

tmux splitw -t 'joynin':2
tmux send-keys -t 'joynin':2 'rvm use 1.9.2@global && sass --watch app/webroot/css/master.sass' C-m

tmux splitw -t 'joynin':2
tmux send-keys -t 'joynin':2 'rvm use 1.9.2@global && coffee --watch --compile app/webroot/js/script.coffee' C-m

tmux select-layout -t 'joynin':2 'even-horizontal'



tmux select-window -t 'joynin':1

fi

if [ -z $TMUX ]; then
    tmux -u attach-session -t 'joynin'
else
    tmux -u switch-client -t 'joynin'
fi