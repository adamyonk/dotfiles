# Variables
set fish_greeting       ''
set --global --export BROWSER       open
set --global --export DOTFILES      $HOME/.dotfiles
set --global --export GIT_SANDBOX   $PROJECTS/sandbox
#set --global --export NGINX_PATH    /opt/nginx
#set --global --export NODE_PATH     /usr/local/lib/node_modules
#set --global --export PGDATA        /usr/local/var/postgres

# Path
set --global --export PATH          ./bin $DOTFILES/bin $HOME/.rbenv/bin $HOME/.rbenv/shims /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin

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
function g;             git $argv; end
function ga;            git add $argv; end
function gaa;           git add --all $argv; end
function gb;            git branch $argv; end
function gba;           git branch --all $argv; end
function gbd;           git branch --delete $argv; end
function gbr;           git browse $argv; end
function gbpr;          git browse -- pulls/adamyonk $argv; end
function gc;            git commit --verbose $argv; end
function gca;           git commit --amend $argv; end
function gcaa;          git commit --amend --author=$argv; end
function gcl;           git clone $argv; end
function gco;           git checkout $argv; end
function gcot;          git checkout --track $argv; end
function gcp;           git cherry-pick $argv; end
function gd;            git diff $argv; end
function gdlc;          git diff --cached HEAD^ $argv; end
function gf;            git fetch $argv; end
function gfl;           git log -u $argv; end
function gfp;           git fetch --prune $argv; end
function gl;            git log --decorate $argv; end
function gla;           git log --abbrev-commit --all --decorate --graph --pretty=oneline $argv; end
function glf;           git log --decorate --numstat --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" $argv; end
function gm;            git merge $argv; end
function gmm;           git merge master $argv; end
function gn;            git n $argv; end
function gpl;           git pull $argv; end
function gpr;           git pull-request $argv; end
function gps;           git push $argv; end
function gr;            git rebase $argv; end
function gra;           git rebase --abort $argv; end
function grc;           git rebase --continue $argv; end
function gre;           git reset $argv; end
function gri;           git rebase --interactive $argv; end
function gs;            git status --branch --short $argv; end
function gst;           git stash $argv; end
function gsta;          git stash apply $argv; end
function gstl;          git stash list $argv; end
function gsts;          git stash save $argv; end
function gsub;          git submodule $argv; end
function gsubu;         git submodule foreach git pull origin master $argv; end
function gsy;           git pull; and git push $argv; end

if which hub >/dev/null
  function git;         hub $argv; end
end

if which hitch >/dev/null
  function unhitch;     hitch --unhitch; end
  #function hitch
  #  command hitch $argv
  #  if test -e "$HOME/.hitch_export_authors"
  #    source "$HOME/.hitch_export_authors"
  #  end
  #end
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

# Tmux
#function tmux;          tmux -2 $argv; end # Force tmux to assume the terminal supports 256 colours
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
