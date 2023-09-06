# https://trello.com/c/hi1zvqeZ
fish_config theme choose "fish/themes/Dracula Official"
starship init fish | source

# https://docs.brew.sh/Manpage#shellenv-bashcshfishpwshshtcshzsh
eval "$(brew shellenv)"

# https://fishshell.com/docs/current/cmds/fish_greeting.html#example
set -U fish_greeting

# https://fishshell.com/docs/current/interactive.html#shared-bindings
set EDITOR nvim
set VISUAL nvim

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
