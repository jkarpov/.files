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

# Escape to normal mode with jj
bindkey "jj" vi-cmd-mode

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

