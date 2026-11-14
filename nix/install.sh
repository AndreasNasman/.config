#!/bin/zsh

SCRIPT_DIR="${0:A:h}"

# https://github.com/nix-darwin/nix-darwin#prerequisites
# https://lix.systems/install/#on-any-other-linuxmacos-system
echo '📦 Installing Nix using the Lix installer as recommended in the nix-darwin documentation.' && sleep 1
curl -sSf -L https://install.lix.systems/lix | sh -s -- install

echo '💾 Sourcing Nix as instructed in the Nix install output.' && sleep 1
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# https://github.com/nix-darwin/nix-darwin#step-2-installing-nix-darwin
echo '📦 Installing Nix packages and building initial system configuration. This step may take a while.' && sleep 1
# URL-encode spaces so Nix parses the path as a valid flake URI.
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake "path:${SCRIPT_DIR// /%20}#haga"

echo '💾 Activating system configuration.' && sleep 1
exec zsh
