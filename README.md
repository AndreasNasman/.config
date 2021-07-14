# Setup

To properly link all files in the directories, these local files should be configured:

`~/.gitconfig`

```shell
[include]
    path = ~/.config/git/gitconfig
```

`~/.zshenv`

```shell
export ZDOTDIR="$HOME/.config/zsh"
source $ZDOTDIR/.zshenv
```

