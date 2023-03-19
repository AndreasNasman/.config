#!/usr/bin/env zsh

echo -e '\n📦 Setting up packages.'
cd $SETUP_DIRECTORY/apt
source init.sh
cd $SETUP_DIRECTORY/apt-manual
source init.sh
cd $SETUP_DIRECTORY/make
source init.sh

echo -e '\n📜 Installing Node v16.'
nvm install 16

echo -e '\n🪄 Opening Neovim for setup.'
nvim
