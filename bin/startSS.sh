#!/bin/sh
#Load Environment
$HOME/.profile;

# Startup Core Smartsheet Environemnt
cd /home/brett/git/core/dev2/;
/usr/bin/vagrant up

# Startup Labs (using play)
screen -S play-labs -d -m /bin/bash -c "$HOME/.profile; cd /home/brett/git/platform-labs/; /opt/play-2.2.1/play run"
