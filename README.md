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

Alternatively, you can clone the repository normally and initialize the submodules by running the `setup/init` script described below.

# Setup

To initialize the setup, run the following script:

```sh
setup/init
```

The script installs Homebrew packages (dependencies) and initializes as many programs as possible from the repository. The script is written in Bash since [fish](https://fishshell) is not installed by default on macOS.

## Template

To replace config files with their base templates (example files), run the following script:

```sh
setup/template
```

This script is handy to check if the config example files contain new information.

## Update

To update relevant files when the setup changes, run the following script:

```sh
setup/update
```

# Manual setup

Some parts of the setup are not feasible to automate in a script. The following section serves as a reminder of what to set up manually.

# Git commit signing with GPG

GPG(GnuPG) must be set up correctly for Git commit signing to work.

Copy `private-key.asc` through a safe method. The key can be exported from another system with the following commands:

```sh
# Copy the desired key ID.
gpg --list-keys
gpg --export-secret-key --armor $KEY_ID > private-key.asc
```

Import `private-key.asc` on the current system with the following command:

```sh
gpg --import private-key.asc
```

**NB: The public key will be imported along with the private key, no need to import it separately.**

https://dotmethod.me/posts/pass-password-manager-share-gpg-key/
