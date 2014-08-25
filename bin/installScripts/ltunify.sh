#!/bin/sh
#logitech command line app to connect unifying usb receiver to devices. Installs in $HOME/bin/ltunify
sudo apt-get install git gcc
cd /opt/local/
git clone https://git.lekensteyn.nl/ltunify.git
cd ltunify
make install-home
