function fish_mode_prompt
    switch $fish_bind_mode
        case default replace_one
            set -l catppuccin_blue 89b4fa
            set_color --bold black --background $catppuccin_blue
            echo ' '
        case insert
            set -l catppuccin_green A6E3A1
            set_color --bold black --background $catppuccin_green
            echo ' '
        case visual
            set -l catppuccin_mauve CBA6F7
            set_color --bold black --background $catppuccin_mauve
            echo ' '
        case '*'
            set -l catppuccin_red F38BA8
            set_color --bold $catppuccin_red
            echo '?'
    end
    set_color normal
end
