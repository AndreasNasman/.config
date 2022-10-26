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

# Case-insensitive completion, partial-word completion (case-sensitively), substring completion.
# https://zsh.sourceforge.io/Guide/zshguide06.html#l170
# https://unix.stackexchange.com/a/647095
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' 'r:|?=**'

# Edit the command line using your visual editor.
# https://unix.stackexchange.com/a/6622
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Search history with <C-r>.
# https://unix.stackexchange.com/a/30169
bindkey '^R' history-incremental-pattern-search-backward

# Aliases
alias l='ls -al'
alias ll='ls -al'
alias ls='ls -al'

alias rm='rm -i'

alias v.='nvim .'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# Path
CONFIG_BIN=$XDG_CONFIG_HOME/bin
export PATH=$CONFIG_BIN:$PATH

# Neovim

## https://wiki.archlinux.org/title/environment_variables#Default_programs
export EDITOR=nvim
export VISUAL=nvim

## Use Neovim as a manpager.
## `:h :Man`
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# GnuPG

# Make `gpg-agent` cache SSH keys.
# https://wiki.archlinux.org/title/GnuPG#Set_SSH_AUTH_SOCK
unset SSH_AGENT_PID
if [ ${gnupg_SSH_AUTH_SOCK_by:-0} -ne $$ ]; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

# Required for GPG to work in an X session.
# https://wiki.archlinux.org/title/GnuPG#Configure_pinentry_to_use_the_correct_TTY
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Node.js
source /usr/share/nvm/init-nvm.sh

# Cambri
CAMBRI_BIN=$HOME/Cambri/bin
export PATH=$CAMBRI_BIN:$PATH
