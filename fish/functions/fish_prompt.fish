function fish_prompt
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showcolorhints true
    printf ' %s%s%s%s%s > ' (set_color $fish_color_cwd) (prompt_pwd --dir-length=1 --full-length-dirs=2) (set_color $fish_color_operator) (fish_git_prompt '  %s') (set_color normal)
end
