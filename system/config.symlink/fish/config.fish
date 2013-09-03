# Source local.fish if it exists
if test -f $HOME/.config/fish/local.fish
  . $HOME/.config/fish/local.fish
end
# Variables
set --global --export BROWSER       open
set --global --export DOTFILES      $PROJECTS/dotfiles
# Path
set --global --export PATH          ./bin $HOME/bin /usr/local/heroku/bin $HOME/.rbenv/bin $HOME/.rbenv/shims /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin $HOME/.coral/bin

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

# Heroku
function h;             heroku $argv; end

# Ruby
function b;             bundle $argv; end
function be;            bundle exec $argv; end
function bi;            bundle install $argv; end
function bu;            bundle update $argv; end
function f;             foreman $argv; end
function fr;            foreman run bundle exec $argv; end
function r;             rake $argv; end
rbenv rehash >/dev/null ^&1
#. /usr/local/share/fry/fry.fish
#set -U fry_auto_switch 1
#fry 1.9.3 >/dev/null ^&1

# System
function fliptable;     echo \n（╯°□°）╯︵ ┻━┻\n; end
function last_modified; ls -t $argv 2> /dev/null | head -n 1; end
function lc;            launchctl $argv; end
function ll;            ls -al $argv; end
function ssh_up;        systemsetup -setremotelogin on; end
function ssh_down;      systemsetup -setremotelogin off; end
function trash;         mv $argv ~/.Trash; end

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

# tmux
#function tmux;          command tmux -2 $argv; end

# Prompt
set fish_greeting       ''
function fish_prompt --description "Set the left side fish prompt"
  if test $status = 0
    set color green # ><((°>
  else
    set color red # ><((ˣ>
  end
  set_color $color
  echo -n ' ✖ '
  set_color normal
  echo -n (basename (echo $PWD | sed -e "s|^$HOME|~|")) [(git_prompt)]
  echo -n ' ➔ '
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
  #echo -n (basename (echo $PWD | sed -e "s|^$HOME|~|")) [(git_prompt)]
end
