#!/bin/zsh

# Install Nix using the Lix installer as recommended in the nix-darwin documentation.
# https://github.com/nix-darwin/nix-darwin#prerequisites
# https://lix.systems/install/#on-any-other-linuxmacos-system
curl -sSf -L https://install.lix.systems/lix | sh -s -- install

# Source Nix as instructed in the Nix install output.
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
