#!/bin/bash

# Author: Simge Ekiz Basar & Erkan Basar
# GitHub: erkanbasar/dotfiles

# Create a symlink to use it with a single command (as shown in Usage).
# sudo ln -sfn /path/to/folder/gu.sh /usr/bin/gu

usage() {
  echo "=== Manual ==="
  echo "gu [e|s]"
  echo "=============="
}

current() {
  echo "=== Current Local User ==="
  git config user.name
  git config user.email
  echo "=========================="
}

[ $# -eq 0 ] && {
  echo
  current
  echo
  usage
  exit
}

if [ $1 == "e" ]; then
  USERNAME="Erkan Basar"
  USEREMAIL="erkan@basar.dev"
elif [ $1 == "s" ]; then
  USERNAME="Simge Ekiz"
  USEREMAIL="simgeekiz48@gmail.com"
else
  usage
  exit
fi;

git config --local --replace-all user.name "$USERNAME"
git config user.name
git config --local --replace-all user.email "$USEREMAIL"
git config user.email
