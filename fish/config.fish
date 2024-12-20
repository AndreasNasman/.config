# https://docs.brew.sh/Manpage#shellenv-bashcshfishpwshshtcshzsh
eval (/opt/homebrew/bin/brew shellenv)
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
source (brew --prefix asdf)/libexec/asdf.fish

# https://sw.kovidgoyal.net/kitty/faq/#things-behave-differently-when-running-kitty-from-system-launcher-vs-from-another-terminal
fish_add_path (brew --prefix)/bin (brew --prefix)/sbin
# To use Homebrew's version, `curl` must be explicitly added to `$PATH`.
fish_add_path /opt/homebrew/opt/curl/bin
# https://gitlab.abo.fi/nasse/todos/-/issues/2136
fish_add_path /opt/homebrew/Cellar/mysql-client@8.4/8.4.3/bin
# Prepend asdf to PATH last always with `--move`.
fish_add_path --move $ASDF_DIR/bin $HOME/.asdf/shims

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

# https://github.com/asdf-vm/asdf-ruby#install
# https://github.com/rbenv/ruby-build/wiki#macos
set --global --export RUBY_CONFIGURE_OPTS --with-openssl-dir=(brew --prefix openssl@3)

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
