# Setup

## Install

To install Homebrew packages, run the following script:

```sh
setup/install
```

Some Homebrew packages, like `fish`, is needed for other scripts to work.

## Main

After install Homebrew packages, run the main script to complete the setup:

```sh
setup/main
```

### Manual

After running the main script, do these manual setup steps to complete the setup:

- Setup GPG and add `user.signingkey` to `$HOME/.gitconfig` to avoid committing the private key.

## Update

```sh
./update.sh
```
