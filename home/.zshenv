# XDG Base Directory Specification
# https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

# xorg-xauth
# https://wiki.archlinux.org/title/XDG_Base_Directory#Supported
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
# Avoids `xauth: file /run/user/1000/Xauthority does not exist` warning.
touch $XAUTHORITY

# xinit
# https://wiki.archlinux.org/title/XDG_Base_Directory#Supported
export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
alias startx="startx $XINITRC -- $XSERVERRC"

# Zsh
# https://wiki.archlinux.org/title/XDG_Base_Directory#Supported
# https://zsh.sourceforge.io/Guide/zshguide02.html#l9
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
