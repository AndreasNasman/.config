#!/usr/bin/env bash

# https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
echo -e '\n🌊 Adding unstable Neovim repository.'
sudo add-apt-repository ppa:neovim-ppa/unstable --yes
echo -e '\n📈 Updating package information.'
sudo apt update

echo -e '\n🎁 Installing packages.'
SOURCE=${BASH_SOURCE[0]}
PACKAGES=$(find . -mindepth 1 -type f -not -name $SOURCE -exec cat '{}' \;)
echo $PACKAGES \
  | xargs sudo apt --yes install
