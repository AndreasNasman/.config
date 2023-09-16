# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set --global --export XDG_CONFIG_HOME (path resolve (status dirname)/../)
set --global --export GNUPGHOME $XDG_CONFIG_HOME/gnupg

# https://fishshell.com/docs/current/interactive.html#shared-bindings
set --global --export EDITOR nvim
set --global --export VISUAL nvim

# https://neovim.io/doc/user/filetype.html#ft-man-plugin
set --global --export MANPAGER 'nvim +Man!'
set --global --export MANWIDTH 999

# https://fishshell.com/docs/current/cmds/fish_greeting.html#example
set --universal fish_greeting

# https://fishshell.com/docs/current/tutorial.html#path
fish_add_path $XDG_CONFIG_HOME/../bin

# https://trello.com/c/hi1zvqeZ
fish_config theme choose 'fish/themes/Dracula Official'
oh-my-posh init fish --config $XDG_CONFIG_HOME/oh-my-posh/dracula.omp.json | source

# https://fishshell.com/docs/current/interactive.html#command-line-editor
fish_vi_key_bindings

# https://docs.brew.sh/Manpage#shellenv-bashcshfishpwshshtcshzsh
eval (brew shellenv)

# https://fishshell.com/docs/current/interactive.html#autosuggestions
# https://github.com/fish-shell/fish-shell/issues/3541#issuecomment-260001906
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \ef forward-word
    end
end
