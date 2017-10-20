#!/bin/bash

echo
echo "------------------------"
echo "Updating Aptitude package manager..."
echo "------------------------"
sudo apt-get update

INSTALL_PKGS="$(cat packages.system)"

for package in $INSTALL_PKGS; do

  echo
  echo "------------------------"
  echo "Installing $package"
  echo "------------------------"

  if ! sudo apt-get -qq install $package; then

    if [[ $package = "fluxgui" ]]; then
        # source: https://github.com/xflux-gui/xflux-gui
        sudo add-apt-repository ppa:nathan-renniewaldock/flux
        sudo apt-get update
        sudo apt-get install fluxgui

    elif [[ $package = "spotify-client" ]]; then
        # source: https://www.spotify.com/nl/download/linux/
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
        echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
        sudo apt-get update
        sudo apt-get install spotify-client

    else
      sudo apt-get install $package
    fi

  else
    echo "Already installed"
  fi

done

DEBPKGS=$HOME/Downloads/deb_packages

if [ ! -d $DEBPKGS ]; then
  mkdir $DEBPKGS
fi

echo
echo "------------------------"
echo "Downloading Google Chrome (See https://www.google.com/chrome/browser/desktop/index.html)"
echo "------------------------"
if [ ! -f $DEBPKGS/google-chrome.deb ]; then
  curl -o $DEBPKGS/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Downloading Atom (See https://atom.io/)"
echo "------------------------"
if [ ! -f $DEBPKGS/atom.deb ]; then
  curl -o  $DEBPKGS/atom.deb https://atom.io/download/deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Downloading WhatsApp Desktop (See https://github.com/Enrico204/Whatsapp-Desktop)"
echo "------------------------"
if [ ! -f $DEBPKGS/whatsapp-desktop.deb ]; then
  curl -o $DEBPKGS/whatsapp-desktop.deb https://github.com/Enrico204/Whatsapp-Desktop/releases/download/v0.3.13/whatsapp-desktop_0.3.13-1_amd64.deb
else
  echo "Already downloaded"
fi

# echo
# echo "------------------------"
# echo "Downloading Skype (See https://www.skype.com/en/download-skype/skype-for-linux/)"
# echo "------------------------"
# if [ ! -f $DEBPKGS/skype-for-linux.deb ]; then
#   curl -o $DEBPKGS/skype-for-linux.deb https://go.skype.com/linux.deb
# else
#   echo "Already downloaded"
# fi

echo
echo "------------------------"
echo "Downloading Slack (See https://slack.com/downloads/linux)"
echo "------------------------"
if [ ! -f $DEBPKGS/slack-desktop.deb ]; then
  curl -o  $DEBPKGS/slack-desktop.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.8.2-amd64.deb
else
  echo "Already downloaded"
fi

echo
echo "------------------------"
echo "Downloading keybase (See https://keybase.io/docs/the_app/install_linux)"
echo "------------------------"
if [ ! -f $DEBPKGS/keybase.deb ]; then
  curl -o $DEBPKGS/keybase.deb https://prerelease.keybase.io/keybase_amd64.deb
else
  echo "Already downloaded"
fi

# echo
# echo "------------------------"
# echo "Installing Downloaded .deb packages under $DEBPKGS/"
# echo "------------------------"
# sudo dpkg -i $DEBPKGS/*.deb
#
# echo
# echo "------------------------"
# echo "Installing the missing dependencies (if there is any)"
# echo "------------------------"
# sudo apt-get install -f
