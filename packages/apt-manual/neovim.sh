#!/usr/bin/env zsh

# https://lindevs.com/install-fd-command-for-finding-files-on-ubuntu
echo '\n🎁 Installing `fd`.'
FD_VERSION=$(curl --silent "https://api.github.com/repos/sharkdp/fd/releases/latest" | grep --only-matching --perl-regexp '"tag_name": "v\K[0-9.]+')
FD_EXECUTABLE="fd.deb"
curl --silent --location --output $FD_EXECUTABLE "https://github.com/sharkdp/fd/releases/latest/download/fd_${FD_VERSION}_amd64.deb"
sudo apt install --yes ./$FD_EXECUTABLE
rm --recursive $FD_EXECUTABLE

# https://lindevs.com/install-ripgrep-on-ubuntu
echo '\n🎁 Installing `ripgrep`.'
RIPGREP_VERSION=$(curl --silent "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep --only-matching --perl-regexp '"tag_name": "\K[0-9.]+')
RIPGREP_EXECUTABLE="ripgrep.deb"
curl --silent --location --output $RIPGREP_EXECUTABLE "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_${RIPGREP_VERSION}_amd64.deb"
sudo apt install --yes ./$RIPGREP_EXECUTABLE
rm --recursive $RIPGREP_EXECUTABLE
