# Lines configured by zsh-newuser-install
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nasse/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Aliases
alias l='ls -al'
alias ll='ls -al'
alias ls='ls -al'

alias rm='rm -i'

alias v.='nvim .'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
