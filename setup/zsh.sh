#!/usr/bin/env bash

REPO_PATH=$(git rev-parse --show-toplevel)

echo -e '\n📂 Creating XDG directories.'
source $REPO_PATH/home/.zshenv
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME

cd $REPO_PATH/home
echo -e '\n💾 Copying files to `$HOME`.'
find . -type f -exec rsync '{}' /home/nasse/'{}' \;
echo -e '\n🔗 Hardlinking copied files.'
find . -type f -exec ln -f $HOME/'{}' '{}' \;

echo -e '\n📦 Installing Oh My Zsh plugins through Git submodules.'
git submodule init && git submodule update

echo -e '\n🔭 Installing `fzf`.'
cd $REPO_PATH
./fzf/install --xdg --no-key-bindings --no-completion --no-update-rc

echo -e '\n🗑️ Removing preinstalled files.'
rm --force $HOME/.bash_logout
rm --force $HOME/.bashrc
rm --force $HOME/.motd_shown
rm --force $HOME/.profile

echo -e '\n🎁 Installing Zsh.'
sudo apt --yes install zsh
echo -e '\n🐚 Setting Zsh as the default shell.'
chsh -s $(which zsh)
echo -e '\n🚀 Launching Zsh.'
exec zsh
