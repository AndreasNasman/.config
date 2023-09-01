fish_config theme choose "fish/themes/Dracula Official"
starship init fish | source

# https://docs.brew.sh/Manpage#shellenv-bashcshfishpwshshtcshzsh
eval "$(brew shellenv)"

# https://fishshell.com/docs/current/cmds/fish_greeting.html#example
set -U fish_greeting

# https://fishshell.com/docs/current/interactive.html#shared-bindings
set EDITOR nvim
set VISUAL nvim
