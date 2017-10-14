#!/bin/bash

BASEDIR="$(pwd)"

# Git
ln -sf $BASEDIR/gitconfig $HOME/.gitconfig

# Shell
ln -sf $BASEDIR/shell/bashrc $HOME/.bashrc
ln -sf $BASEDIR/shell/bash_profile $HOME/.bash_profile
ln -sf $BASEDIR/shell/bash_aliases $HOME/.bash_aliases
ln -sf $BASEDIR/shell/bash_logout $HOME/.bash_logout

# Custom Scripts
sudo ln -sf $BASEDIR/scripts/tunnel.sh /usr/bin/tunnel
sudo ln -sf $BASEDIR/scripts/srunl.sh /usr/bin/srunl

# Guake
ln -sf $BASEDIR/guake/ $HOME/.gconf/apps/guake

# Atom
ln -sf $BASEDIR/atom/ $HOME/.atom

# Autostart
ln -sf $BASEDIR/autostart/ $HOME/.config/autostart
