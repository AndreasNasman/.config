#!/usr/bin/env zsh

echo -e '\n🎣 Installing manually fetched packages with `make`.'
SOURCE=$(basename $0)
find . -type f -executable -not -name $SOURCE -exec '{}' \;
