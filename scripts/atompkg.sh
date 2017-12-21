#!/bin/bash

usage() {
  echo "=========================== Manual ============================"
  echo "Usage;"
  echo "       ./atompkg -l: List the installed plugins and save the list to a file"
  echo "       ./atompkg -i: Install the plugins from the saved file"
  echo "       ./atompkg -s: Star all of the installed plugins"
  echo "==============================================================="
  exit
}

[ $# -eq 0 ] && {
  usage
}

PKGLIST=$HOME/.dotfiles/atom/packages.list

if [ $1 == "-s" ]; then
  apm star --installed
elif [ $1 == "-l" ]; then
  apm list --installed --bare > $PKGLIST
  cat $PKGLIST
elif [ $1 == "-i" ]; then
  apm install --packages-file $PKGLIST
else
  usage
fi
