# Variables
set fish_greeting       ''
set -g -x BROWSER       open
set -g -x DOTFILES      $HOME/.dotfiles
set -g -x GIT_SANDBOX   $PROJECTS/sandbox
#set -g -x NGINX_PATH    /opt/nginx
#set -g -x NODE_PATH     /usr/local/lib/node_modules
#set -g -x PGDATA        /usr/local/var/postgres

# Path
set -g -x PATH          ./bin
set -g -x PATH          $PATH   $DOTFILES/bin
set -g -x PATH          $PATH   $HOME/.rbenv/bin
set -g -x PATH          $PATH   $HOME/.rbenv/shims
set -g -x PATH          $PATH   /usr/local/bin
set -g -x PATH          $PATH   /usr/bin
set -g -x PATH          $PATH   /bin

# Local Settings
if test -f $HOME/.config/fish/local.fish
  . $HOME/.config/fish/local.fish
end

# Editor
if which mvim >/dev/null
  set -g -x VIM 'mvim -v'
else
  set -g -x VIM 'vim'
end
set -g -x EDITOR        $VIM
alias e                 $EDITOR

# Git
alias g                 'git'
alias ga                'git add'
alias gaa               'git add --all'
alias gb                'git branch'
alias gba               'git branch --all'
alias gbd               'git branch --delete'
alias gbr               'git browse'
alias gbpr              'git browse -- pulls/adamyonk'
alias gc                'git commit --all --verbose'
alias gca               'git commit --amend'
alias gcl               'git clone'
alias gco               'git checkout'
alias gcot              'git checkout --track'
alias gcp               'git cherry-pick'
alias gd                'git diff'
alias gdlc              'git diff --cached HEAD^'
alias gf                'git fetch'
alias gfl               'git log -u'
alias gfp               'git fetch --prune'
alias gl                'git log --decorate'
alias gla               'git log --abbrev-commit --all --decorate --graph --pretty=oneline'
alias glf               'git log --decorate --numstat --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]"'
alias gm                'git merge'
alias gmm               'git merge master'
alias gn                'git n'
alias gpl               'git pull'
alias gpr               'git pull-request'
alias gps               'git push'
alias gr                'git rebase'
alias gra               'git rebase --abort'
alias grc               'git rebase --continue'
alias gre               'git reset'
alias gri               'git rebase --interactive'
alias gs                'git status --branch --short'
alias gst               'git stash'
alias gsta              'git stash apply'
alias gstl              'git stash list'
alias gsts              'git stash save'
alias gsub              'git submodule'
alias gsy               'git pull; and git push'

alias g                 'git'
alias ga                'git add'
alias gaa               'git add --all'
alias gb                'git branch'
alias gba               'git branch --all'
alias gbd               'git branch --delete'
alias gbr               'git browse'
alias gbpr              'git browse -- pulls/adamyonk'
alias gc                'git commit --verbose'
alias gca               'git commit --amend'
alias gcl               'git clone'
alias gco               'git checkout'
alias gcot              'git checkout --track'
alias gcp               'git cherry-pick'
alias gd                'git diff'
alias gdlc              'git diff --cached HEAD^'
alias gf                'git fetch'
alias gfl               'git log -u'
alias gfp               'git fetch --prune'
alias gl                'git log --decorate'
alias gla               'git log --abbrev-commit --all --decorate --graph --pretty=oneline'
alias glf               'git log --decorate --numstat --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]"'
alias gm                'git merge'
alias gmm               'git merge master'
alias gn                'git n'
alias gpl               'git pull'
alias gpr               'git pull-request'
alias gps               'git push'
alias gr                'git rebase'
alias gra               'git rebase --abort'
alias grc               'git rebase --continue'
alias gre               'git reset'
alias gri               'git rebase --interactive'
alias gs                'git status --branch --short'
alias gst               'git stash'
alias gsta              'git stash apply'
alias gstl              'git stash list'
alias gsts              'git stash save'
alias gsub              'git submodule'
alias gsubu             'git submodule foreach git pull origin master'
alias gsy               'git pull; and git push'

if which hub >/dev/null
  alias git             'hub'
end

if which hitch >/dev/null
  alias unhitch         'hitch --unhitch'
  #function hitch
  #  command hitch "$@"
  #  if [[ -s "$HOME/.hitch_export_authors" ]] ; then source "$HOME/.hitch_export_authors" ; fi
  #end
end

function sandbox
  cd $GIT_SANDBOX; and git clone $argv; and cd `last_modified`
end

# Ruby
alias be                'bundle exec'
alias bi                'bundle install'
alias fr                'bundle exec foreman run bundle exec'
rbenv rehash >/dev/null ^&1

# System
alias fliptable         'echo "\n（╯°□°）╯︵ ┻━┻\n"'
alias last_modified     'ls -t $argv 2> /dev/null | head -n 1'
alias ll                'ls -al'

# Tmux
alias tmux              'tmux -2' # Force tmux to assume the terminal supports 256 colours
function mx
  if test -z $argv
    set SESSION `basename $PWD`
  else
    set SESSION $argv
  end

  if test -x $DOTFILES/tmux/layouts/$SESSION
    $DOTFILES/tmux/layouts/$SESSION
  else
    if ! tmux has-session -t $SESSION
      tmux new-session -s $SESSION -n shell -d
    end
    tmux attach -t $SESSION
  end
end

# Shell
alias reload        '. $HOME/.config/fish/config.fish'

# Prompt
function git_branch
  if test -d "./.git"
    printf (git branch --all | grep '*' | cut -d ' ' -f 2-)
  end
end

function fish_prompt
  echo -n  '✖  '
end

function fish_right_prompt
  echo -n (git_branch)
end
