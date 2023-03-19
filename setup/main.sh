#!/usr/bin/env zsh

echo -e '\n📦 Installing Oh My Zsh plugins through Git submodules.'
git submodule init && git submodule update

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

echo -e '\n📦 Setting up packages.'
cd $SETUP_DIRECTORY/apt
source init.sh
cd $SETUP_DIRECTORY/apt-manual
source init.sh
cd $SETUP_DIRECTORY/make
source init.sh

echo -e '\n🔭 Installing `fzf`.'
cd $REPO_PATH
git clone --quiet --depth 1 https://github.com/junegunn/fzf.git
./fzf/install --xdg --no-key-bindings --no-completion --no-update-rc

echo -e '\n💻 Installing Oh My Zsh with existing config.'
sh -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo -e '\n📜 Installing Node v16.'
nvm install 16

echo -e '\n🪄 Opening Neovim for setup.'
nvim

echo -e '\n🗑️ Removing preinstalled files.'
rm --force $HOME/.bash_logout
rm --force $HOME/.bashrc
rm --force $HOME/.motd_shown
rm --force $HOME/.profile
