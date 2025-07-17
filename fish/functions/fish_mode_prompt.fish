function fish_mode_prompt
    switch $fish_bind_mode
        case default replace_one
            set -l catppuccin_blue 7aa2f7
            set_color --bold black --background $catppuccin_blue
            echo ' '
        case insert
            set -l catppuccin_green 9ece6a
            set_color --bold black --background $catppuccin_green
            echo ' '
        case visual
            set -l catppuccin_mauve bb9af7
            set_color --bold black --background $catppuccin_mauve
            echo ' '
        case '*'
            set -l catppuccin_red f7768e
            set_color --bold $catppuccin_red
            echo '?'
    end
    set_color normal
end
