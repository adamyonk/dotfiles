export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true

fpath=($DOTFILES/zsh/functions $fpath)

autoload -U $DOTFILES/zsh/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history # Adds history instead of replacing
setopt no_bg_nice # Don't nice background tasks
setopt complete_aliases # Don't expand aliases _before_ completion has finished, like: git comm-[tab]
setopt complete_in_word # Complete from both ends when inside word
setopt correct # Try to correct commands
setopt no_correct_all # Don't correct arguments
setopt extended_history # Add timestamps to history
setopt hist_ignore_all_dups # Don't record dupes in history
setopt hist_reduce_blanks # Remove superfluous blanks
setopt hist_verify # Load lines from history expansion nito editing buffer
setopt no_hup # Send the HUP signal to running jobs when the shell exits
setopt ignore_eof # Don't exit on EOF
setopt inc_append_history # Add lines to history as soon as they're added
setopt no_list_beep # Beep on an ambiguous completion
setopt local_options # Allow functions to have local options
setopt local_traps # Allow functions to have local traps
setopt prompt_subst # Parameter expansion, command substitution, arithmetic expansion performed in prompts
setopt share_history # Adds history incrementally and share it across sessions

# Vi-mode. Borrowign this from oh-my-zsh
function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v

# Completion
# Matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Verbose complettion
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# Initialize autocomplete
autoload -U compinit
compinit

compdef g=git
