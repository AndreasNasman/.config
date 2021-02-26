# zprof
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/andreasnasman/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

## nvm
## Must be set before zsh-nvm is loaded.
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(evalcache git vi-mode wd zsh-nvm yarn zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.config/powerlevel10k/p10k.zsh.
[[ ! -f ~/.config/powerlevel10k/p10k.zsh ]] || source ~/.config/powerlevel10k/p10k.zsh

# -------------------- #

# VALUES

## Needed for IntelliJ to find settings for IdeaVim.
export XDG_CONFIG_HOME="$HOME/.config"

# CONFIGURATIONS

## Bitwarden
if command -v bw > /dev/null 2>&1; then
  export BW_SESSION="dbwnuLePcXPD1YUaB37/sJ2+16yQ7b/zG8WUUTF4rgxV9iN0ZrHFiZ8JCYGnhRHEUg3bR90N+QC0Gu9Mro+AFA=="
  _evalcache bw completion --shell zsh; compdef _bw bw;
fi

## Docker
if command -v docker-machine > /dev/null 2>&1; then
  _evalcache docker-machine env default
fi

## jenv
if command -v jenv > /dev/null 2>&1; then
  export PATH="$HOME/.jenv/bin:$PATH"
  _evalcache jenv init -
fi

## Homebrew
### Customizes 'fpath' to prefer Zsh's own git completion (with a symlink) to the one `brew install git` does.
fpath=( $HOME/.local/share/zsh/site-functions $fpath )

## Vim
export MYVIMRC="$HOME/.config/vim/vimrc"
export VIMINIT="source $MYVIMRC"

# FUNCTIONS

function time_zsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# -------------------- #

# HIBOX

## VALUES

MY_IP="$(ipconfig getifaddr en0)"

## FUNCTIONS

local HIBOX_CENTRE_PATH="/opt/hibox/centre/"

function tomcat_kill() {
  echo "Forcefully shutting down all Tomcat instances!🙀"
  pkill -9 -f tomcat
}

function tomcat_start() {
  echo "Starting Tomcat...😻"
  "${HIBOX_CENTRE_PATH}tomcat/bin/startup.sh"
  tail -f "${HIBOX_CENTRE_PATH}tomcat/logs/catalina.out"
}

function weinre_start() {
  local -r WEINRE_HTTP_PORT=8001
  npx weinre --httpPort=$WEINRE_HTTP_PORT --boundHost=$MY_IP
}

