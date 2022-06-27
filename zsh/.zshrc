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

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

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

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

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

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install



# ------------- #

# *************
# User settings
# *************


# ---------
# Variables
# ---------

#
# Zsh
#

# Edit the command line using your visual editor.
bindkey -M vicmd ' ' edit-command-line

# Increase history size
local SIZE=1000000000
export HISTFILESIZE=$SIZE
export HISTSIZE=$SIZE

setopt EXTENDED_HISTORY # Add timestamp to the commands saved in history.

#
# General
#

# Add `XDG_CONFIG_HOME` variable. Needed for e.g. IntelliJ to find settings for IdeaVim.
export XDG_CONFIG_HOME=$HOME/.config

# Use NeoVim as the default editor for programs.
export VISUAL=nvim
export EDITOR=$VISUAL

# Use NeoVim as the man page viewer.
export MANPAGER='nvim +Man!'
export MANWIDTH=999

#
# Vim
#

# NOTE: Also affects which config file NeoVim will use.
#export MYVIMRC=$XDG_CONFIG_HOME/vim/vimrc
#export VIMINIT=source $MYVIMRC


# ---
# fzf
# ---

[ -f $XDG_CONFIG_HOME/fzf/.fzf.zsh ] && source $XDG_CONFIG_HOME/fzf/.fzf.zsh


# -------
# Aliases
# -------

alias rm='rm -i'

alias v.='nvim .'
alias v=nvim
alias vi=nvim
alias vim=nvim

alias vf.='vifm .'
alias vf=vifm


# -------------
# Powerlevel10k
# -------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of $XDG_CONFIG_HOME/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit $XDG_CONFIG_HOME/powerlevel10k/p10k.zsh.
[[ ! -f $XDG_CONFIG_HOME/powerlevel10k/p10k.zsh ]] || source $XDG_CONFIG_HOME/powerlevel10k/p10k.zsh


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

# jenv
if command -v jenv > /dev/null 2>&1; then
  export PATH=$HOME/.jenv/bin:$PATH
  _evalcache jenv init -
fi
'

#
# Homebrew
#

# Customize 'fpath' to prefer Zsh's own git completion (with a symlink) to the one `brew install git` does.
fpath=( $HOME/.local/share/zsh/site-functions $fpath )

#
# n
#

# Customize `n` install location to avoid hazzle with `brew` (`brew doctor` specifically).
export N_PREFIX=$XDG_CONFIG_HOME/n

#
# Binary executables
#

local S_BIN=/usr/local/sbin # (system binaries, used by some programs installed with `brew`)
local N_BIN=$N_PREFIX/bin
local CUSTOM_BIN=$XDG_CONFIG_HOME/bin
local HIBOX_BIN=$XDG_CONFIG_HOME/bin/hibox
export PATH=$S_BIN:$N_BIN:$CUSTOM_BIN:$HIBOX_BIN:$PATH


# ---------
# Functions
# ---------

#
# eval
#

function eval_bitwarden() {
  _evalcache bw completion --shell zsh; compdef _bw bw;
}

function eval_jenv() {
  export PATH=$HOME/.jenv/bin:$PATH
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
export MY_IP=$(ipconfig getifaddr en10)
if [ -z $MY_IP ]; then
  # Wi-Fi
  export MY_IP=$(ipconfig getifaddr en0)
fi


# ---------
# Functions
# ---------

local HIBOX_CENTRE_PATH='/opt/hibox/centre'
local HIBOX_REPO_PATH=$HOME/Projects/Hibox/hiboxcentre

function gradle_dev_build() {
  echo '\n📦 Running `devBuild` with Gradle'
  $HIBOX_REPO_PATH/gradlew -p $HIBOX_REPO_PATH devBuild
}

function tomcat_kill() {
  echo '\n🙀 Forcefully shutting down all Tomcat instances'
  pkill -9 -f tomcat
}

function tomcat_log() {
  tail -f $HIBOX_CENTRE_PATH/tomcat/logs/catalina.out
}

function tomcat_shutdown() {
  echo '\n😿 Shutting down Tomcat'
  $HIBOX_CENTRE_PATH/tomcat/bin/shutdown.sh
}

function tomcat_startup() {
  echo '\n😻 Starting Tomcat'
  $HIBOX_CENTRE_PATH/tomcat/bin/startup.sh
}

function tomcat_restart() {
  echo '\n😼 Restarting Tomcat'
  eval_jenv && tomcat_shutdown && gradle_dev_build && tomcat_startup
}

function weinre_start() {
  echo '\n🌭 Starting Weinre'
  local WEINRE_HTTP_PORT=8001
  npx weinre --httpPort=$WEINRE_HTTP_PORT --boundHost=$MY_IP
}


# -------------- #

