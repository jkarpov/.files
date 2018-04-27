# PATH
export PATH=$HOME/.cabal/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

autoload -Uz compinit promptinit
compinit
promptinit

# User configuration
export LANG=en_US.UTF-8
export EDITOR='vim'
export LD_LIBRARY_PATH=/run/opengl-driver/lib
# tmuxinator window naming
export DISABLE_AUTO_TITLE=true
compdef mux='tmuxinator'

setopt GLOB_COMPLETE
setopt PUSHD_MINUS

# case insensitive globbing
setopt NO_CASE_GLOB

# load colors
autoload -Uz colors && colors


# command completion
# auto-complete with keyboard
zstyle ':completion:*' menu select
# case insensitive competion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# generate discriptions
zstyle ':completion:*' auto-description 'specify: %d'
# autocompletion of cmd line switches for aliases
setopt completealiases

bindkey -v

# history
export HISTSIZE=1000
export SAVEHIST=1000
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
# write after each command
setopt INC_APPEND_HISTORY
unsetopt share_history

# rehash automatically so new files in path are found
zstyle ':competion:*' rehash true


alias vi="vim"
alias dot='git --git-dir=$HOME/.unix/ --work-tree=$HOME'
alias grep='grep --color=always'
alias hl='hledger'
alias hlp='hledger print -x'
alias mux='tmuxinator'


export FZF_DEFAULT_OPTS="--extended --color=light --reverse"

bindkey '^R' history-incremental-search-backward
bindkey '^ ' complete-word


# enable integration with fzf on nixos
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

