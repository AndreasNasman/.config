#!/usr/bin/env bash

echo '📰 Updating and upgrading installed packages.'
sudo apt update --yes
sudo apt upgrade --yes

SETUP_DIRECTORY=$(dirname $(realpath $0))
cd $SETUP_DIRECTORY

if [ -x "$(command -v zsh)" ];
then
  source ./main.sh
else
  source ./zsh.sh
fi
