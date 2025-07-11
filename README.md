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

The following section serves as a reminder of what to set up manually.

## Firefox

1. Navigate to <about:config>.
1. Set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.
1. Restart Firefox.

### Git

We need to set up SSH commit signing manually since we should exclude signing
keys from version control. `git/config` contains an include-reference to a
`config.local` file that contains the signing key. Follow these steps to add the
signing key:

1. Open the desktop version 1Password.
1. Find the signing key item.
1. Click the "More options" menu (three dots) and choose "Configure Commit
   Signing...".
1. Copy the `user.signingkey` part and add it to the `git/config.local` file.

### Surfingkeys

1. Open Surfingkeys settings.
1. Tick the `Advanced mode` checkbox.
1. Paste the content below in the `Load settings from:` text field.

```plain
https://raw.githubusercontent.com/AndreasNasman/.config/refs/heads/main/surfingkeys/theme.js
```

## Nix

### Troubleshooting

#### `system.keyboard` configurations not working

After a macOS system update, your Nix keyboard configurations might stop
working.

To remedy this, run this command
([source](https://github.com/nix-darwin/nix-darwin/issues/905#issuecomment-2816336630))
and make note of the path:

```sh
nix-store --query --tree /run/current-system  | grep --only-matching --extended-regexp '/nix/store/.+-activate-system-start' | xargs nix-store --query --requisites | grep bash
```

Then, open Input Monitoring in System Settings and add the Bash command to the
allowed applications.

If you run `darwin-rebuild` and restart your system, keyboard changes will take
effect! 🎉

## Neovim

I have based my Neovim configuration on
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), hash
[3338d39](https://github.com/nvim-lua/kickstart.nvim/commit/3338d3920620861f8313a2745fd5d2be39f39534).

## Inspiration

- <https://github.com/nvim-lua/kickstart.nvim>
- <https://www.lazyvim.org/>
- <https://www.youtube.com/@benfrainuk>
- <https://www.youtube.com/@devopstoolbox>
- <https://www.youtube.com/@dreamsofcode>
- <https://www.youtube.com/@joseanmartinez>
- <https://www.youtube.com/@vhyrro>
