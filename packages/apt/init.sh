#!/usr/bin/env zsh

# https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
echo '\n🌊 Adding stable Neovim repository.'
sudo add-apt-repository ppa:neovim-ppa/stable --yes
echo '\n📈 Updating package information.'
sudo apt update

echo '\n🎁 Installing packages.'
CURRENT_FILE_NAME=$(basename $0)
PACKAGES=$(find . -mindepth 1 -type f -not -name $CURRENT_FILE_NAME -exec cat '{}' \;)
echo $PACKAGES \
  | xargs sudo apt --yes install
