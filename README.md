# Setup

## Install

The scripts in this repository rely on [fish](https://fishshell.com/). However, since macOS does not include `fish` by default, a separate Bash script installs dependencies – thereamong `fish` – as Homebrew packages.

To install packages (dependencies), run the following script:

```sh
setup/install
```

## Main

The main setup script copies over files that must be in `$HOME`.

To invoke the main setup, run the following script:

```sh
setup/main
```

## Manual

After running the main script, do these manual setup steps to complete the setup:

- Setup GPG and add `user.signingkey` to `$HOME/.gitconfig` to avoid committing the private key.

## Update

To update relevant files when the setup changes, run the following script:

```sh
./update.sh
```
