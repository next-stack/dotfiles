#!/bin/bash

BASEDIR="$(pwd)"

# Git
ln -sfn $BASEDIR/gitconfig $HOME/.gitconfig

# Shell
ln -sfn $BASEDIR/shell/bashrc $HOME/.bashrc
ln -sfn $BASEDIR/shell/bash_profile $HOME/.bash_profile
ln -sfn $BASEDIR/shell/bash_aliases $HOME/.bash_aliases
ln -sfn $BASEDIR/shell/bash_logout $HOME/.bash_logout

# Custom Scripts
sudo ln -sfn $BASEDIR/scripts/tunnel.sh /usr/bin/tunnel
sudo ln -sfn $BASEDIR/scripts/srunl.sh /usr/bin/srunl

# Guake
ln -sfn $BASEDIR/guake/ $HOME/.gconf/apps/guake

# Atom
ln -sfn $BASEDIR/atom/ $HOME/.atom

# Autostart
ln -sfn $BASEDIR/autostart/ $HOME/.config/autostart
