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
