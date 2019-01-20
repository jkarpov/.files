# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export TERM=xterm-256color

# prompt
PS1="\n\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"

alias mux='tmuxinator'
alias dot='git --git-dir=$HOME/.files/ --work-tree=$HOME'
alias r='ranger'

export LANG=en_US.UTF-8

# editor
export EDITOR="nvim"
set editing-mode vi
set -o vi


bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'



# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# history
export HISTSIZE=10000
export SAVEHIST=10000

# Save and reload the history after each command finishes
HISTCONTROL=ignoredups:erasedups
shopt -s histappend # append to history, don't overwrite it
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# fzf
export FZF_DEFAULT_OPTS="--extended --color=light --reverse"
if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi
