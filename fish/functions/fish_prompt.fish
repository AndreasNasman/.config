function fish_prompt
    printf ' %s%s%s%s%s > ' (set_color $fish_color_cwd) (prompt_pwd --dir-length=0) (set_color $fish_color_operator) (fish_git_prompt '  %s') (set_color normal)
end
