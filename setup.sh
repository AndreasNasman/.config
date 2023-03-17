#!/usr/bin/env bash

echo '📦 Installing Oh My Zsh plugins through Git submodules.'
git submodule init && git submodule update

echo '📂 Creating XDG directories.'
source home/.zshenv
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME

cd $XDG_CONFIG_HOME/home
echo '💾 Copying files to `$HOME`.'
find . -type f -exec rsync '{}' /home/nasse/'{}' \;
echo '🔗 Hardlinking copied files.'
find . -type f -exec ln -f $HOME/'{}' '{}' \;

echo '📰 Updating and upgrading installed packages.'
sudo apt update --yes
sudo apt upgrade --yes

echo -e '\n📦 Setting up packages.'
cd $XDG_CONFIG_HOME/packages/apt
source init.sh
cd $XDG_CONFIG_HOME/packages/apt-manual
source init.sh
cd $XDG_CONFIG_HOME/packages/make
source init.sh

echo -e '\n🔭 Installing `fzf`.'
cd $XDG_CONFIG_HOME
git clone --quiet --depth 1 https://github.com/junegunn/fzf.git
./fzf/install --xdg --no-key-bindings --no-completion --no-update-rc

echo -e '\n💻 Installing Oh My Zsh with existing config.'
cd $HOME
sh -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo -e '\n📜 Installing Node v16.'
/bin/zsh -i -c 'nvm install 16'

echo -e '\n🪄 Opening Neovim for setup.'
/bin/zsh -i -c 'nvim'

echo -e '\n🗑️ Removing preinstalled files.'
rm --force $HOME/.bash_logout
rm --force $HOME/.bashrc
rm --force $HOME/.motd_shown
rm --force $HOME/.profile

echo -e '\n🐚 Setting Zsh as the default shell.'
chsh -s $(which zsh)
exec zsh
