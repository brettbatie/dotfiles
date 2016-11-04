#!/bin/sh

# PM utils is required to hook to the sleep/power events
sudo aptitude install pm-utils
cd /opt

# Get the latest code
git clone https://github.com/phillipberndt/autorandr.git

# Add autorandr to the path
sudo ln -s /opt/autorandr/autorandr.py /usr/local/bin/autorandr


sudo cp /opt/autorandr/contrib/bash_completion/autorandr /etc/bash_completion.d/

# Setup the script to run specific events occur power/sleep/dock/undock
sudo cp /opt/autorandr/contrib/pm-utils/40autorandr /usr/lib/pm-utils/sleep.d/
sudo cp /opt/autorandr/contrib/pm-utils/40autorandr /usr/lib/pm-utils/power.d/
sudo cp /opt/autorandr/contrib/udev/40-monitor-hotplug.rules /etc/udev/rules.d/

# reload the rules
sudo udevadm control --reload-rules
