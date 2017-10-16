#!/bin/bash

echo "Installing Git..."
if sudo apt-get -qq install git; then
  echo "Already installed."
else
  sudo apt-get install git
fi

echo "Installing Pip..."
if sudo apt-get -qq install python-pip; then
  echo "Already installed."
else
  sudo apt-get install python-pip
  pip install --upgrade pip
fi

echo "Installing Screen..."
if sudo apt-get -qq install screen; then
  echo "Already installed."
else
  sudo apt-get install screen
fi

echo "Installing Virtualenv..."
if sudo apt-get -qq install virtualenv; then
  echo "Already installed."
else
  sudo apt-get install virtualenv
fi

echo "Installing Shellcheck..."
if sudo apt-get -qq install shellcheck; then
  echo "Already installed."
else
  # source: https://community.linuxmint.com/software/view/shellcheck
  sudo apt-get install shellcheck
fi
