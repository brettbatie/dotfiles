#!/bin/bash

#Note: this script runs on boot to help the login manager to use the appropriate monitors. 
# I modified the file /etc/lightdm/lightdm.conf and added the following line to the [SeatDefaults] section:
# display-setup-script = /home/brett/dotfiles/bin/dock.sh

/usr/bin/xrandr |/bin/grep "HDMI2 connected"
if [ $? -eq 0 ]; then
    # initial monitor setup at (two monitors and docked laptop) but it tends to fail to initialize both monitors. 
    /usr/bin/xrandr --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
                    --output HDMI3 --mode 1920x1080 --pos 1920x0 \
                    --output LVDS1 --off
    # Hack: the above command tends to not initialize both monitors. To fix this we disabled the monitors and try again.
    sleep 1; 
    /usr/bin/xrandr --output DP3 --off \
                    --output DP2 --off \
                    --output DP1 --off \
                    --output HDMI3 --off \
                    --output HDMI2 --off \
                    --output HDMI1 --off \
                    --output LVDS1 --primary --mode 1600x900 --pos 0x0 --rotate normal \
                    --output VGA1 --off;

#    /usr/bin/xrandr --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
#                    --output HDMI3 --mode 1920x1080 --pos 1920x0 \
#                    --output LVDS1 --off;
    xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal  --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output LVDS1 --mode 1360x768 --pos 3840x312 --rotate normal --output VGA1 --off
fi


#FIXME: http://unix.stackexchange.com/questions/4489/a-tool-for-automatically-applying-randr-configuration-when-external-display-is-p
# Use a udev rule.
#
# NOTE: the below commands work but is cpu intensive.

#
# while true; do
#     # Check for connected but not in use
#     /usr/bin/xrandr |/bin/grep "HDMI2 connected (normal"
#     connected=$?

#     # Check for disconnected
#     /usr/bin/xrandr |/bin/grep "HDMI2 disconnected"
#     disconnected=$?
    
#     # if the 2nd monitor is connected but not setup
#     if [ $connected == 0 ]; then
        
#         # Setup secondary monitor
#         /usr/bin/xrandr --output HDMI2 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
#                         --output HDMI3 --mode 1920x1080 --pos 1920x0 \
#                         --output LVDS1 --off
#     # if the 2nd monitor is disconnected
#     elif [ $disconnected == 0 ]; then
#         # Setup laptop monitor
#         /usr/bin/xrandr --output DP3 --off \
#                         --output DP2 --off \
#                         --output DP1 --off \
#                         --output HDMI3 --off \
#                         --output HDMI2 --off \
#                         --output HDMI1 --off \
#                         --output LVDS1 --primary --mode 1600x900 --pos 0x0 --rotate normal \
#                         --output VGA1 --off
#     fi
#     sleep 4;
# done
