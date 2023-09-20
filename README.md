# Prerequisites

Make sure you have the _Command Line Tools (CLT)_ installed, which are needed for cloning this repository with Git and for Homebrew.

```sh
xcode-select --install
```

Disable _System Integrity Protection_ to access all yabai features.

https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection

# Cloning

This repository contains submodules. You can initialize them when cloning by running:

```sh
git clone --recurse-submodules https://github.com/AndreasNasman/.config.git
```

Alternatively, you can clone the repository normally and initialize the submodules by running the install-script described below.

# Setup

## Install

The scripts in this repository rely on [fish](https://fishshell.com/). However, since macOS does not include `fish` by default, a separate Bash script installs dependencies – thereamong `fish` – as Homebrew packages.

To install packages (dependencies), run the following script:

```sh
setup/install
```

## Update

To update relevant files when the setup changes, run the following script:

```sh
./update.sh
```

## Manual

Some parts of the setup are not feasible to automate in a script. The following list serves as a reminder on what to setup manually:

- GPG for Git commit signing.
