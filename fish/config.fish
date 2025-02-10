# https://docs.brew.sh/Manpage#shellenv-bashcshfishpwshshtcshzsh
eval (/opt/homebrew/bin/brew shellenv)

# https://asdf-vm.com/guide/getting-started.html#_2-configure-asdf
# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# To use Homebrew's version, `curl` must be explicitly added to `$PATH`.
fish_add_path (brew --prefix curl)/bin
# https://gitlab.abo.fi/nasse/todos/-/issues/2136
fish_add_path (brew --prefix mysql-client)@8.4/bin

# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set --global --export XDG_CONFIG_HOME (path resolve (status dirname)/../)
set --global --export GNUPGHOME $XDG_CONFIG_HOME/gnupg

# https://fishshell.com/docs/current/interactive.html#shared-bindings
set --global --export EDITOR nvim
set --global --export VISUAL nvim

# https://neovim.io/doc/user/filetype.html#ft-man-plugin
set --global --export MANPAGER 'nvim +Man!'
set --global --export MANWIDTH 999

# https://trello.com/c/Zm0ToMQm
set --global --export SKETCHY_BAR_HEIGHT 20

set --global --export LG_CONFIG_FILE "$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/lazygit/themes-mergable/mocha/yellow.yml"

# https://fishshell.com/docs/current/cmds/fish_greeting.html#example
set --universal fish_greeting

# https://fishshell.com/docs/current/cmds/alias.html
alias cal='cal -3'
alias cp='cp -i'
alias lg='lazygit'
alias rm='rm -i'

alias nvim="nvim --listen /tmp/nvim-server.$KITTY_WINDOW_ID"

# Use the `nvim` alias to benefit from its function.
alias v.='nvim .'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# https://trello.com/c/hi1zvqeZ
fish_config theme choose 'fish/themes/Catppuccin Mocha'

# https://fishshell.com/docs/current/interactive.html#command-line-editor
fish_vi_key_bindings

# https://fishshell.com/docs/current/interactive.html#autosuggestions
# https://github.com/fish-shell/fish-shell/issues/3541#issuecomment-260001906
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \ef forward-word
    end
end
