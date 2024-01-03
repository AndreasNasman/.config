# https://docs.brew.sh/Manpage#shellenv-bashcshfishpwshshtcshzsh
eval (/opt/homebrew/bin/brew shellenv)

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
alias rm='rm -i'

# Use `command` to avoid an infinite recursion loop.
# https://fishshell.com/docs/2.0/index.html#syntax-function-wrappers
alias nvim='set --erase NVIM_APPNAME; command nvim'

# Use `command` to invoke `nvim` directly.
alias lv.='set --global --export NVIM_APPNAME LazyVim; command nvim .'
alias lv='set --global --export NVIM_APPNAME LazyVim; command nvim'

# Use the `nvim` alias to benefit from its function.
alias v.='nvim .'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# https://fishshell.com/docs/current/tutorial.html#path
fish_add_path $XDG_CONFIG_HOME/bin

# https://trello.com/c/hi1zvqeZ
fish_config theme choose 'fish/themes/Catppuccin Mocha'
oh-my-posh init fish --config (brew --prefix oh-my-posh)/themes/catppuccin_mocha.omp.json | source

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

# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
source (brew --prefix asdf)/libexec/asdf.fish
