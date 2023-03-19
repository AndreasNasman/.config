#!/usr/bin/env bash

echo -e '\n🎁 Installing Zsh.'
sudo apt --yes install zsh
echo -e '\n🐚 Setting Zsh as the default shell.'
chsh -s $(which zsh)
echo -e '\n🚀 Launching Zsh.'
exec zsh
