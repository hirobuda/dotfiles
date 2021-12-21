# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=10000
setopt notify
bindkey -v
eval "$(starship init zsh)"
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hiroshi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
