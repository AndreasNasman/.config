# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install


# ------------- #

# *************
# User settings
# *************


# -------------
# Powerlevel10k
# -------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/powerlevel10k/p10k.zsh.
[[ ! -f ~/.config/powerlevel10k/p10k.zsh ]] || source ~/.config/powerlevel10k/p10k.zsh


# ---------
# Variables
# ---------

#
# General
#

# Adds `XDG_CONFIG_HOME` variable. Needed for e.g. IntelliJ to find settings for IdeaVim.
export XDG_CONFIG_HOME=$HOME/.config
# Adds `sbin` (used by some programs installed with `brew`) and a custom `bin` directory among the config files to `PATH`.
export PATH="/usr/local/sbin:${XDG_CONFIG_HOME}/bin:$PATH"

#
# Vim
#

export MYVIMRC="$HOME/.config/vim/vimrc"
export VIMINIT="source $MYVIMRC"


# --------------
# Configurations
# --------------

#
# Automatic eval
#

: '
# Bitwarden
if command -v bw > /dev/null 2>&1; then
  _evalcache bw completion --shell zsh; compdef _bw bw;
fi

# Docker
if command -v docker-machine > /dev/null 2>&1; then
  _evalcache docker-machine env default
fi

# jenv
if command -v jenv > /dev/null 2>&1; then
  export PATH="$HOME/.jenv/bin:$PATH"
  _evalcache jenv init -
fi
'

#
# Homebrew
#

# Customizes 'fpath' to prefer Zsh's own git completion (with a symlink) to the one `brew install git` does.
fpath=( $HOME/.local/share/zsh/site-functions $fpath )


# ---------
# Functions
# ---------

#
# eval
#

function eval_bitwarden() {
  _evalcache bw completion --shell zsh; compdef _bw bw;
}

function eval_docker() {
  _evalcache docker-machine env default
}

function eval_jenv() {
  export PATH="$HOME/.jenv/bin:$PATH"
  _evalcache jenv init -
}

#
# Debugging
#

function time_zsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}


# -------------- #

# **************
# Hibox settings
# **************


# ---------
# Values
# ---------

# Docking station
MY_IP="$(ipconfig getifaddr en10)"
if [ -z "$MY_IP" ]; then
  # Wi-Fi
  MY_IP="$(ipconfig getifaddr en0)"
fi


# ---------
# Functions
# ---------

local HIBOX_CENTRE_PATH="/opt/hibox/centre"
local HIBOX_REPO_PATH="${HOME}/Projects/Hibox/hiboxcentre"

function gradle_dev_build() {
  echo '\n📦 Running `devBuild` with Gradle'
  "${HIBOX_REPO_PATH}/gradlew" -p "${HIBOX_REPO_PATH}"
}

function tomcat_kill() {
  echo '\n🙀 Forcefully shutting down all Tomcat instances'
  pkill -9 -f tomcat
}

function tomcat_log() {
  tail -f "${HIBOX_CENTRE_PATH}/tomcat/logs/catalina.out"
}

function tomcat_shutdown() {
  echo '\n😿 Shutting down Tomcat'
  "${HIBOX_CENTRE_PATH}/tomcat/bin/shutdown.sh"
}

function tomcat_startup() {
  echo '\n😻 Starting Tomcat'
  "${HIBOX_CENTRE_PATH}/tomcat/bin/startup.sh"
}

function tomcat_restart() {
  echo '\n😼 Restarting Tomcat'
  tomcat_shutdown && gradle_dev_build && tomcat_startup
}

function weinre_start() {
  echo '\n🌭 Starting Weinre'
  local -r WEINRE_HTTP_PORT=8001
  npx weinre --httpPort=$WEINRE_HTTP_PORT --boundHost=$MY_IP
}


# -------------- #

