#!/bin/bash

#Note: this script runs on boot to help the login manager to use the appropriate monitors. 
# I modified the file /etc/lightdm/lightdm.conf and added the following line to the [SeatDefaults] section:
# display-setup-script = /home/brett/dotfiles/bin/dock.sh

/usr/bin/xrandr |/bin/grep "HDMI2 connected"
if [ $? -eq 0 ]; then
    xrandr --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 3840x180 --rotate normal --output VGA1 --off
fi
