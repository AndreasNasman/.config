#!/usr/bin/env zsh

# Setup Oh My Zsh plugins through Git submodules.
git submodule init && git submodule update

cd home
# Copy files in directories to their correct place in `$HOME`.
DIRECTORIES_TO_HOME=$(find . -mindepth 1 -type d)
echo $DIRECTORIES_TO_HOME \
  | xargs -I {} cp --recursive --no-target-directory {} $HOME/{}
# Copy files to `$HOME`.
FILES_TO_HOME=$(find . -maxdepth 1 -type f -printf "%f\n")
echo $FILES_TO_HOME \
  | xargs -I {} rsync {} /home/nasse/{}
# Hardlink files copied above.
FILES_TO_HARDLINK=$(find . -type f -printf "%P\n")
echo $FILES_TO_HARDLINK \
  | xargs -I {} ln -f $HOME/{} {}

# Create XDG directories.
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_STATE_HOME
