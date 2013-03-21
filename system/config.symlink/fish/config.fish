# Variables
set fish_greeting       ''
set --global --export BROWSER       open
set --global --export DOTFILES      $HOME/.dotfiles
set --global --export GIT_SANDBOX   $PROJECTS/sandbox
#set --global --export NGINX_PATH    /opt/nginx
#set --global --export NODE_PATH     /usr/local/lib/node_modules
#set --global --export PGDATA        /usr/local/var/postgres

# Path
set --global --export PATH          ./bin $DOTFILES/bin /usr/local/heroku/bin $HOME/.rbenv/bin $HOME/.rbenv/shims /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin

# Local Settings
if test -f $HOME/.config/fish/local.fish
  . $HOME/.config/fish/local.fish
end

# Editor
if which mvim >/dev/null
  set --global --export VIM     'mvim -v'
else
  set --global --export VIM     'vim'
end
set --global --export   EDITOR  $VIM
set --global --export   VISUAL  $VIM
function e;             eval $EDITOR $argv; end

# Git
function g
  if test -z "$argv"
    git status --branch --short
  else
    git $argv
  end
end

if which hub >/dev/null
  function git;         hub $argv; end
end

if which hitch >/dev/null
  function unhitch;     hitch --unhitch; end
end

function sandbox --description "Clone and open code for sandboxing"
  cd $GIT_SANDBOX; and git clone $argv; and cd `last_modified`
end

# Ruby
function be;            bundle exec $argv; end
function bi;            bundle install $argv; end
function fr;            bundle exec foreman run bundle exec $argv; end
rbenv rehash >/dev/null ^&1

# System
function fliptable;     echo \n（╯°□°）╯︵ ┻━┻\n; end
function last_modified; ls -t $argv 2> /dev/null | head -n 1; end
function ll;            ls -al $argv; end
function trash;         mv $argv ~/.Trash; end

# Tmux
function mx --description "Launch a tmux project"
  if test -z $argv
    set SESSION (basename $PWD)
  else
    set SESSION $argv
  end

  if test -x $DOTFILES/tmux/layouts/$SESSION
    eval $DOTFILES/tmux/layouts/$SESSION
  else
    if not tmux has-session -t $SESSION
      tmux new-session -s $SESSION -n shell -d
    end
    tmux attach -t $SESSION
  end
end

# Vagrant
function v;             vagrant $argv; end
function vd;            vagrant destroy $argv; end
function vh;            vagrant halt $argv; end
function vp;            vagrant provision $argv; end
function vr;            vagrant reload $argv; end
function vs;            vagrant ssh $argv; end
function vu;            vagrant up $argv; end

# Shell
function reload;        . $HOME/.config/fish/config.fish $argv; end

# Prompt
function fish_prompt --description "Set the left side fish prompt"
  if test $status = 0
    set color normal # ><((°>
  else
    set color red # ><((ˣ>
  end
  set_color $color
  echo -n ' ✖  '
  set_color normal
end

function git_prompt --description "Git branch and staus info for prompt"
  git status >/dev/null ^&1
  if test $status = 0 # In a git repo?
    git diff --quiet HEAD ^&-
    if test $status = 1
      set color red
    else
      set color green
    end
    echo -n (set_color $color)(git branch ^&- | awk '/*/ {print $2}')(set_color normal)
    #echo -n (set_color $color)'±'(set_color normal)
  else
    echo -n ''
  end
end

function fish_right_prompt --description "Set the right side fish prompt"
  #__fish_git_prompt
  echo -n (basename (echo $PWD | sed -e "s|^$HOME|~|")) (git_prompt)
end
