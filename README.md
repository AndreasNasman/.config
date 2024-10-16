# Prerequisites

Make sure you have the _Command Line Tools (CLT)_ installed, which are needed
for cloning this repository with Git and for Homebrew.

```sh
xcode-select --install
```

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

This script installs Homebrew packages (dependencies) and initializes as many
programs as possible from the repository. It uses Bash since macOS does not
include [fish](https://fishshell) out of the box.

## Update

To update relevant files when the setup changes, run the following script:

```sh
setup/update
```

# Manual setup

Some parts of the setup are not feasible to automate in a script. The following
section serves as a reminder of what to set up manually.

# GPG keys

For Git commit signing to work, you must set up GPG with some keys.

Copy `private-key.asc` through a safe method, e.g., from a password manager. If
needed, export the key from another system with the following commands:

```sh
# Copy the desired key ID.
gpg --list-keys
gpg --export-secret-key --armor $KEY_ID > private-key.asc
```

Import `private-key.asc` on the current system with the following command:

```sh
gpg --import private-key.asc
```

Modify the trust of the key with the following command:

```sh
gpg --edit-key $KEY_ID trust quit
# Follow the prompt to set the trust level to `ultimate`.
```

**NB: Importing a private key also includes its public counterpart.**

<https://dotmethod.me/posts/pass-password-manager-share-gpg-key/>  
<https://unix.stackexchange.com/a/392355>
