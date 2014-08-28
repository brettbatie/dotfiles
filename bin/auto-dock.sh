#!/bin/sh
#Note: this script runs by adding a rule to udev. I created a file /etc/udev/rules.d/80-switch-monitors.rules and added the following line to it:
#DEVPATH=="/devices/pci0000:00/0000:00:02.0/drm/card0", ACTION=="change", RUN+="/home/brett/dotfiles/bin/auto-dock.sh"


#work in progress: I should cleanup the below commands to only work with one monitor at a time. Check for HDMI2 if present enable only HDMI2, etc
# http://unix.stackexchange.com/questions/4489/a-tool-for-automatically-applying-randr-configuration-when-external-display-is-p
echo "running" >> /home/brett/log.txt
output=$(cat /sys/class/drm/card0-HDMI-A-2/status)
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
    xrandr --output HDMI2 --off
    xrandr --output HDMI3 --off
xrandr --output HDMI3 --mode 1920x1080 --pos 0x0 --rotate normal
xrandr --output HDMI2 --primary --mode 1920x1080 --left-of HDMI3 --rotate normal
xrandr --output LVDS1 --pos 3840x312 --mode 1360x768 --rotate normal
fi
