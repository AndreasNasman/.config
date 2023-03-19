#!/usr/bin/env zsh

# https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
echo -e '\n🌊 Adding unstable Neovim repository.'
sudo add-apt-repository ppa:neovim-ppa/unstable --yes
echo -e '\n📈 Updating package information.'
sudo apt update

echo -e '\n🎁 Installing packages.'
SOURCE=$(basename $0)
PACKAGES=$(find . -type f -not -name $SOURCE -exec cat '{}' \;)
echo $PACKAGES \
  | xargs sudo apt --yes install
