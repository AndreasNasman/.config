#!/usr/bin/zsh

# Inspiration:
# https://www.reddit.com/r/archlinux/comments/65ocd3/comment/dgc08w6

for package in $(pacman --query --explicit --quiet)
do
  grep --max-count=1 "\[ALPM\] installed $package " /var/log/pacman.log
done \
  | sort --unique \
  | sed -e 's/^.*\[ALPM\] installed //' -e 's/(.*$//' # Remove extraneous leading and trailing text.
