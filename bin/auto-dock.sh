#!/bin/sh
#Note: this script runs by adding a rule to udev. I created a file /etc/udev/rules.d/80-switch-monitors.rules and added the following line to it:
#DEVPATH=="/devices/pci0000:00/0000:00:02.0/drm/card0", ACTION=="change", RUN+="/home/brett/dotfiles/bin/auto-dock.sh"


#work in progress: I should cleanup the below commands to only work with one monitor at a time. Check for HDMI2 if present enable only HDMI2, etc
# http://unix.stackexchange.com/questions/4489/a-tool-for-automatically-applying-randr-configuration-when-external-display-is-p
echo "running" >> /home/brett/log.txt
output=$(cat /sys/class/drm/card0-HDMI-A-3/status)
export DISPLAY=:0.0
export XAUTHORITY=/home/brett/.Xauthority

if [ $output = disconnected ]; then
    /usr/bin/xrandr --output DP3 --off \
                    --output DP2 --off \
                    --output DP1 --off \
                    --output HDMI3 --off \
                    --output HDMI2 --off \
                    --output HDMI1 --off \
                    --output LVDS1 --primary --mode 1360x768 --pos 0x0 --rotate normal \
                    --output VGA1 --off
elif [ $output = connected ]; then
    #xrandr --output DP1 --off --output DP2 --mode 2560x1440 --pos 0x0 --rotate normal --output DP3 --mode 2560x1440 --pos 2560x0 --rotate normal --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
    #xrandr --output DP3 --mode 2048x1152 --pos 2048x0 --rotate normal --output DP2 --mode 2048x1152 --pos 0x0 --rotate normal --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
    ~/dotfiles/bin/./desktop.sh
fi
