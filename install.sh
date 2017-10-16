#!/bin/bash

echo "Installing Guake Terminal..."
if sudo apt-get -qq install guake; then
  echo "Already installed."
else
  sudo apt-get install guake
fi

echo "Installing f.lux..."
if sudo apt-get -qq install fluxgui; then
  echo "Already installed."
else
  # source: https://github.com/xflux-gui/xflux-gui
  sudo add-apt-repository ppa:nathan-renniewaldock/flux
  sudo apt-get update
  sudo apt-get install fluxgui
fi

echo "Installing Spotify..."
if sudo apt-get -qq install spotify-client; then
  echo "Already installed."
else
  # source: https://www.spotify.com/nl/download/linux/
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update
  sudo apt-get install spotify-client
fi

echo "Installing numlockx..."
if sudo apt-get -qq install numlockx; then
  echo "Already installed."
else
  # source: https://sites.google.com/site/easytipsforlinux/numlock-on-at-login-screen-1
  sudo apt-get install numlockx
fi

echo "Installing OpenVPN..."
if sudo apt-get -qq install openvpn; then
  echo "Already installed."
else
  sudo apt-get install openvpn
fi

# Google Chrome
echo "Install Google Chrome --> https://www.google.com/chrome/browser/desktop/index.html"

# Dropbox
echo "Install Dropbox --> https://www.dropbox.com/install-linux"

# Atom
echo "Install Atom --> https://atom.io/"

# WhatsApp
echo "Install WhatsApp --> https://github.com/Enrico204/Whatsapp-Desktop"

# Skype
echo "Install Skype --> https://www.skype.com/en/download-skype/skype-for-linux/"

# Slack
echo "Install Slack --> https://slack.com/downloads/linux"
