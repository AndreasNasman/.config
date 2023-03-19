#!/usr/bin/env zsh

echo -e '\n🎣 Installing manually fetched packages with `apt`.'
SOURCE=$(basename $0)
find . -type f -executable -not -name $SOURCE -exec '{}' \;
