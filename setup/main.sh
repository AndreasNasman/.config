#!/usr/bin/env zsh

SETUP_DIRECTORY=$(dirname $(realpath $0))
cd $SETUP_DIRECTORY

echo -e '\n📦 Setting up packages.'
cd $SETUP_DIRECTORY/apt
source init.sh
cd $SETUP_DIRECTORY/apt-manual
source init.sh
cd $SETUP_DIRECTORY/make
source init.sh

echo -e '\n📜 Installing Node v16.'
REPO_PATH=$(git rev-parse --show-toplevel)
source $REPO_PATH/zsh/.zshrc
nvm install 16

echo -e '\n🪄 Opening Neovim for setup.'
nvim
