function fish_prompt
    printf ' %s%s%s%s%s > ' (set_color $fish_color_cwd) (prompt_pwd --dir-length=1 --full-length-dirs=2) (set_color $fish_color_operator) (fish_git_prompt '  %s') (set_color normal)
end
