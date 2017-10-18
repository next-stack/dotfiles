#!/bin/bash

echo "Updating Aptitude package manager"
sudo apt-get update

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

echo "Installing Steam..."
if sudo apt-get -qq install steam-launcher; then
  echo "Already installed."
else
  # .deb file download: http://store.steampowered.com/about/
  sudo apt-get install steam-launcher
fi

# Google Chrome
echo "Downloading Google Chrome (See https://www.google.com/chrome/browser/desktop/index.html)"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P $HOME/Downloads/

# Dropbox
echo "Downloading Dropbox (See https://www.dropbox.com/install-linux)"
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb -P $HOME/Downloads/
# TODO: See nemo-dropbox!

# Atom
echo "Downloading Atom (See https://atom.io/)"
wget https://atom.io/download/deb -P $HOME/Downloads/

# WhatsApp
echo "Downloading WhatsApp Desktop (See https://github.com/Enrico204/Whatsapp-Desktop)"
wget https://github.com/Enrico204/Whatsapp-Desktop/releases/download/v0.3.13/whatsapp-desktop_0.3.13-1_amd64.deb -P $HOME/Downloads/

# Skype
echo "Downloading Skype (See https://www.skype.com/en/download-skype/skype-for-linux/)"
wget https://go.skype.com/linux.deb -P $HOME/Downloads/

# Slack
echo "Downloading Slack (See https://slack.com/downloads/linux)"
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.2-amd64.deb -P $HOME/Downloads/
# TODO: See http://tipsonubuntu.com/2016/07/15/install-slack-client-ubuntu-16-04/

echo "Installing Google Chrome, Dropbox, Atom, WhatsApp, Skype, Slack..."
sudo dpkg -i $HOME/Downloads/*.deb
sudo apt-get install -f
