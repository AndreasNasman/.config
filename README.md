# Dotfiles

## Prerequisites

Make sure you have the _Command Line Tools (CLT)_ installed, which are needed
for cloning this repository with Git and for Homebrew.

```sh
xcode-select --install
```

## Cloning

This repository contains submodules. You can initialize them when cloning by
running:

```sh
git clone --recurse-submodules https://github.com/AndreasNasman/.config.git
```

Alternatively, you can clone the repository normally and initialize the
submodules by running the `setup/init` script described below.

## Setup

To initialize the setup, run the following script:

```sh
setup/init
```

This script installs Homebrew packages (dependencies) and initializes as many
programs as possible from the repository. It uses Bash since macOS does not
include [fish](https://fishshell) out of the box.

## Update

To update relevant files when the setup changes, run the following script:

```sh
setup/update
```

## Manual setup

Some parts of the setup are not feasible to automate in a script. The following
section serves as a reminder of what to set up manually.

### Git commit signing with SSH

You should keep the key to sign Git commits with SSH out of version control.
`git/config` contains an include-reference to a `config.local` file that
contains the signing key. Follow these steps to add the signing key:

1. Open the desktop version 1Password.
1. Find the signing key item.
1. Click the "More options" menu (three dots) and choose "Configure Commit
   Signing...".
1. Copy the `user.signingkey` part and add it to `git/config.local` file.

### Surfingkeys

1. Open Surfingkeys settings.
1. Tick the `Advanced mode` checkbox.
1. Paste

```plain
https://raw.githubusercontent.com/AndreasNasman/.config/refs/heads/main/surfingkeys/theme.js
```

in the `Load settings from:` text field.

## Neovim

I have based my Neovim configuration on
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), hash
[34e7d29](https://github.com/nvim-lua/kickstart.nvim/commit/34e7d29aa7b6e95cf09d62baf4c9082db5b129c0).

## Inspiration

- <https://github.com/nvim-lua/kickstart.nvim>
- <https://www.lazyvim.org/>
- <https://www.youtube.com/@benfrainuk>
- <https://www.youtube.com/@devopstoolbox>
- <https://www.youtube.com/@dreamsofcode>
- <https://www.youtube.com/@joseanmartinez>
- <https://www.youtube.com/@vhyrro>
