#!/usr/bin/env zsh

echo '\n🎣 Installing manually fetched packages.'
CURRENT_FILE_NAME=$(basename $0)
find . -mindepth 1 -executable -not -name $CURRENT_FILE_NAME -exec '{}' \;
