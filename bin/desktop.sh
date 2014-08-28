#!/bin/sh
xrandr --output HDMI3 --mode 1920x1080 --pos 0x0 --rotate normal
xrandr --output HDMI2 --mode 1920x1080 --left-of HDMI3 --rotate normal
xrandr --output LVDS1 --pos 3840x312 --mode 1360x768 --rotate normal
