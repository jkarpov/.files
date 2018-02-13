# PATH
export PATH=$HOME/.cabal/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH


# User configuration
export LANG=en_US.UTF-8
#export TERM=xterm


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

bindkey -v

#DISABLE_AUTO_TITLE="true"

# custom
#alias sudo='sudo env PATH=$PATH'

alias xclip="xclip -selection c"

alias grep='grep --color=auto -n'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias hl='hledger'
alias hlp='hledger print -x'

alias mux='tmuxinator'
compdef mux='tmuxinator'


alias dot='git --git-dir=$HOME/.linux/ --work-tree=$HOME'

bindkey '^R' history-incremental-search-backward
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey '^ ' autosuggest-accept
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit
autoload -Uz compinit && compinit
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export LD_LIBRARY_PATH=/run/opengl-driver/lib

# tmuxinator window naming
export DISABLE_AUTO_TITLE=true

# enable integration with fzf on nixos
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/completion.zsh"
  source "$(fzf-share)/key-bindings.zsh"
fi

