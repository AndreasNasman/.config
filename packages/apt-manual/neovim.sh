#!/usr/bin/env zsh

# https://lindevs.com/install-fd-command-for-finding-files-on-ubuntu
echo '\n🎁 Installing `fd`.'
FD_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/fd/releases/latest" | grep --only-matching --perl-regexp '"tag_name": "v\K[0-9.]+')
FD_EXECUTABLE="fd.deb"
curl -Lo $FD_EXECUTABLE "https://github.com/sharkdp/fd/releases/latest/download/fd_${FD_VERSION}_amd64.deb"
sudo apt install --yes ./$FD_EXECUTABLE
rm -rf $FD_EXECUTABLE

# https://lindevs.com/install-ripgrep-on-ubuntu
echo '\n🎁 Installing `ripgrep`.'
RIPGREP_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep --only-matching --perl-regexp '"tag_name": "\K[0-9.]+')
RIPGREP_EXECUTABLE="ripgrep.deb"
curl -Lo $RIPGREP_EXECUTABLE "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_${RIPGREP_VERSION}_amd64.deb"
sudo apt install --yes ./$RIPGREP_EXECUTABLE
rm -rf $RIPGREP_EXECUTABLE
