#!/bin/bash

# Author: Simge Ekiz Basar & Erkan Basar
# GitHub: erkanbasar/dotfiles

# Create a symlink to use it with a single command (as shown in Usage).
# sudo ln -sfn /path/to/folder/gu.sh /usr/bin/gu

usage() {
  echo "=========================== Manual ============================"
  echo "gu [e|s]"
  echo "==============================================================="
  exit
}

[ $# -eq 0 ] && {
  usage
}

if [ $1 == "e" ]; then
  USERNAME="Erkan Basar"
  USEREMAIL="erkan@mebasar.com"
elif [ $1 == "s" ]; then
  USERNAME="Simge Ekiz"
  USEREMAIL="simgeekiz48@gmail.com"
else
  exit
fi;

git config --replace-all user.name "$USERNAME"
git config user.name
git config --replace-all user.email "$USEREMAIL"
git config user.email
