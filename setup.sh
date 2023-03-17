#!/usr/bin/env zsh

echo '📦 Installing Oh My Zsh plugins through Git submodules.'
git submodule init && git submodule update

echo '📂 Creating XDG directories.'
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME

cd $XDG_CONFIG_HOME/home
echo '📁 Copying files in directories to their correct place in `$HOME`.'
DIRECTORIES_TO_HOME=$(find . -mindepth 1 -type d)
echo $DIRECTORIES_TO_HOME \
  | xargs -I '{}' cp --recursive --no-target-directory '{}' $HOME/'{}'
echo '💾 Copying files to `$HOME`.'
FILES_TO_HOME=$(find . -maxdepth 1 -type f -printf "%f\n")
echo $FILES_TO_HOME \
  | xargs -I '{}' rsync '{}' /home/nasse/'{}'
echo '🔗 Hardlinking copied files.'
FILES_TO_HARDLINK=$(find . -type f -printf "%P\n")
echo $FILES_TO_HARDLINK \
  | xargs -I '{}' ln -f $HOME/'{}' '{}'

echo '📰 Updating and upgrading installed packages.'
sudo apt update --yes
sudo apt upgrade --yes

echo '\n📦 Setting up packages.'
cd $XDG_CONFIG_HOME/packages/apt
source init.sh
cd $XDG_CONFIG_HOME/packages/apt-manual
source init.sh
cd $XDG_CONFIG_HOME/packages/make
source init.sh

echo '\n🐚 Setting Zsh as the default shell.'
chsh -s $(which zsh)

echo '\n💻 Installing Oh My Zsh with existing config.'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mv $XDG_CONFIG_HOME/zsh/.zshrc.pre-oh-my-zsh $XDG_CONFIG_HOME/zsh/.zshrc

echo '\n🗑️ Removing preinstalled files.'
rm --force $HOME/.bash_logout
rm --force $HOME/.bashrc
rm --force $HOME/.motd_shown
rm --force $HOME/.profile

echo '\n🪄 Opening Neovim for setup.'
nvim
