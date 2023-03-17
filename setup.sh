#!/usr/bin/env zsh

echo '📦 Setting up Oh My Zsh plugins through Git submodules.'
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
echo '🔗 Hardlink copied files.'
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
