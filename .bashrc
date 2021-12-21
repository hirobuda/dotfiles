#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
export PS1="{\[\e[1;36m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \W}$ "
export PATH=$PATH:"/home/hiroshi/.local/bin"
[ -f "/home/hiroshi/.ghcup/env" ] && source "/home/hiroshi/.ghcup/env" # ghcup-env
eval "$(starship init bash)"
