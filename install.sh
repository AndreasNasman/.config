#!/bin/zsh

# https://github.com/nix-darwin/nix-darwin#prerequisites
# https://lix.systems/install/#on-any-other-linuxmacos-system
echo '📦 Installing Nix using the Lix installer as recommended in the nix-darwin documentation.' && sleep 1
curl -sSf -L https://install.lix.systems/lix | sh -s -- install

echo '💾 Sourcing Nix as instructed in the Nix install output.' && sleep 1
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# https://github.com/nix-darwin/nix-darwin#step-2-installing-nix-darwin
echo '📦 Installing nix-darwin. This step may take a while.' && sleep 1
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ./nix#haga
