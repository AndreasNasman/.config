#!/usr/bin/zsh

# Inspiration:
# https://www.reddit.com/r/archlinux/comments/65ocd3/comment/dgc08w6

INSTALLED_PACKAGES=$(
  for package in $(pacman --query --explicit --quiet)
  do
    grep --max-count=1 "\[ALPM\] installed $package " /var/log/pacman.log
  done \
    | sort --unique \
    | sed -e 's/^.*\[ALPM\] installed //' -e 's/(.*$//' # Remove extraneous leading and trailing text.
)

if [[ $* == '--kde' ]]
then
  LAST_KDE_PACKAGE_INDEX=46
  echo $INSTALLED_PACKAGES \
    | tail -n+$LAST_KDE_PACKAGE_INDEX \
    | sort
else
  echo $INSTALLED_PACKAGES
fi
