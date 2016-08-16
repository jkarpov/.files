# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export TERM=xterm-256color

# prompt
PS1="\n\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%F %T "

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# editor
set -o vi
export EDITOR="vim"

# remember last directory
LAST_DIR=$HOME/.cache/last_dir
function cd()
{
  builtin cd "$@"
  pwd > $LAST_DIR
}
[ -f $LAST_DIR ] && cd `cat $LAST_DIR`


########################
# variables
########################

export NODE_PATH=$NODE_PATH:/usr/lib/node_modules/

########################
# aliases
########################
alias sudo='sudo env PATH=$PATH'
alias v='vim .'
alias vi='vim'

alias ls='ls --color=auto'
alias ll='ls++'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto -n'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias sqlite='sqlite3 -column -header'
alias rscp='rsync -v -P -e ssh'
alias clip='xclip -sel clip'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# other custom configs
[ -f ~/.bash_local ] && . ~/.bash_local


export PATH=$PATH:$HOME/.rvm/bin:$GOPATH/bin:$HOME/.local/bin


alias config='/usr/bin/git --git-dir=/home/dima/.linux/ --work-tree=/home/dima'
