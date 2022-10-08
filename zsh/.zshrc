# Lines configured by zsh-newuser-install
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt autocd beep extendedglob hist_ignore_all_dups interactive_comments nomatch notify share_history
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nasse/.config/zsh/.zshrc'

autoload -Uz compinit
# End of lines added by compinstall

# https://wiki.archlinux.org/title/XDG_Base_Directory#Supported
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# Aliases
alias l='ls -al'
alias ll='ls -al'
alias ls='ls -al'

alias rm='rm -i'

alias v.='nvim .'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Neovim

## https://wiki.archlinux.org/title/environment_variables#Default_programs
export EDITOR=nvim
export VISUAL=nvim

## Use Neovim as a manpager.
## `:h :Man`
export MANPAGER='nvim +Man!'
export MANWIDTH=999
