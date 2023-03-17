#!/usr/bin/env bash

echo -e '\n🎣 Installing manually fetched packages with `make`.'
SOURCE=${BASH_SOURCE[0]}
find . -mindepth 1 -executable -not -name $SOURCE -exec '{}' \;
