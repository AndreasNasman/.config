# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Configure Zsh history file.
HISTFILE_DIR=$XDG_STATE_HOME/zsh
if [[ ! -d $HISTFILE_DIR ]]; then
  mkdir $HISTFILE_DIR
fi
HISTFILE=$HISTFILE_DIR/history
HISTSIZE=1000000000
SAVEHIST=1000000000

# Open WSL tabs in the same directory.
# https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory#zsh
keep_current_path() {
  printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)

# If you come from bash you might have to change your $PATH.
CAMBRI_BIN=$XDG_CONFIG_HOME/bin/cambri
export PATH=$CAMBRI_BIN:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$XDG_CONFIG_HOME/zsh/custom

# Specify a custom install directory for `nvm`.
# https://github.com/lukechilds/zsh-nvm#custom-directory
export NVM_DIR=$XDG_CONFIG_HOME/.nvm

# `fzf` path.
export FZF_BASE=$XDG_CONFIG_HOME/fzf

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  zsh-nvm

  # fzf should be loaded last to avoid keybinding problems.
  # https://github.com/jeffreytse/zsh-vi-mode/issues/24
  fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Enable hidden files completion.
# https://unix.stackexchange.com/a/366137
setopt globdots

# Use Neovim as a manpager.
# `:h :Man`
export MANPAGER="nvim +Man!"
export MANWIDTH=999

# https://wiki.archlinux.org/title/environment_variables#Default_programs
export EDITOR=nvim
export VISUAL=nvim

# Installation path to the `cambri2` repo: https://gitlab.com/cambri/maxdiff-pilot/cambri2.
# Needed for scripts in `$CAMBRI_BIN`.
export CAMBRI_TOOL=$HOME/cambri2

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias code="code-insiders"
alias rm="rm -i"
alias v.="nvim ."
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
