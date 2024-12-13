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

### GPG keys

GPG keys should be device-specific. If you configure them with an expiration
date, GitHub can show commits as "Verified" but expired. This approach
eliminates the need to copy private keys between devices (which you should not
do anyway).

Follow these guides to set up GPG commit signing:

- <https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification#gpg-commit-signature-verification>
- <https://docs.gitlab.com/ee/user/project/repository/signed_commits/gpg.html>

### Surfingkeys

1. Open Surfingkeys settings.
1. Tick the `Advanced mode` checkbox.
1. Paste

```plain
https://raw.githubusercontent.com/AndreasNasman/.config/refs/heads/mac/surfingkeys/theme.js
```

in the `Load settings from:` text field.

## Neovim

I have based my Neovim configuration on
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), hash
[8d1ef97](https://github.com/nvim-lua/kickstart.nvim/commit/8d1ef972bc32faa86fee21a57f9033b41f612ebb).

## Inspiration

- <https://github.com/nvim-lua/kickstart.nvim>
- <https://www.lazyvim.org/>
- <https://www.youtube.com/@benfrainuk>
- <https://www.youtube.com/@devopstoolbox>
- <https://www.youtube.com/@dreamsofcode>
- <https://www.youtube.com/@joseanmartinez>
- <https://www.youtube.com/@vhyrro>
