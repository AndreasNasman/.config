#!/usr/bin/env bash

# https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Unix#1ubuntudebian-user

SCRIPT_DIRECTORY=$(dirname $(realpath $0))

echo -e '\n🎁 Installing `lua`.'
LUA_VERSION=$(curl --silent "http://www.lua.org/ftp/" | grep --only-matching --perl-regexp "lua-(\d+\.)+\d" | head --lines=1)
curl --silent --remote-time --remote-name "http://www.lua.org/ftp/$LUA_VERSION.tar.gz"
tar --gzip --extract --file=$LUA_VERSION.tar.gz
cd $LUA_VERSION
make linux test
sudo make install
cd $SCRIPT_DIRECTORY
rm --recursive $LUA_VERSION*

echo -e '\n🎁 Installing `luarocks`.'
LUA_ROCKS_VERSION=$(curl --silent --location "https://luarocks.org/releases/" | grep --only-matching --perl-regexp "luarocks-(\d+\.)+\d" | head --lines=1)
curl --silent --location --remote-time --remote-name "https://luarocks.org/releases/$LUA_ROCKS_VERSION.tar.gz"
tar --gzip --extract --preserve-permissions --file=$LUA_ROCKS_VERSION.tar.gz
cd $LUA_ROCKS_VERSION
./configure --with-lua-include=/usr/local/include
make
sudo make install
cd $SCRIPT_DIRECTORY
rm --recursive $LUA_ROCKS_VERSION*
