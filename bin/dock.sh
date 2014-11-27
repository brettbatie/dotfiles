#!/bin/sh

#Note: this script runs on boot to help the login manager to use the appropriate monitors. 
# I modified the file /etc/lightdm/lightdm.conf and added the following line to the [SeatDefaults] section:
# display-setup-script = /home/brett/dotfiles/bin/dock.sh

#/usr/bin/xrandr |/bin/grep "HDMI3 connected"
output=$(cat /sys/class/drm/card0-DP-2/status)
if [ $output = connected ]; then
    xrandr --output LVDS1 --off
    sleep 2;
    #xrandr --output DP1 --off --output DP2 --mode 2560x1440 --pos 0x0 --rotate normal --output DP3 --mode 2560x1440 --pos 2560x0 --rotate normal --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
    #--output DP2 --mode 2560x1440 --pos 0x0 --rotate normal 
#    xrandr --output DP3 --mode 2048x1152 --pos 2048x0 --rotate normal --output DP2 --mode 2048x1152 --pos 0x0 --rotate normal --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
    /home/brett/dotfiles/bin/./desktop.sh
fi
