# #!/bin/sh
# exit
# xrandr is buggy and using this combo seems to get it to go to the higher resolution. :-/
# /usr/bin/xrandr --output DP3 --off \
#                     --output DP2 --off \
#                     --output DP1 --off \
#                     --output HDMI3 --off \
#                     --output HDMI2 --off \
#                     --output HDMI1 --off \
#                     --output LVDS1 --primary --mode 1360x768 --pos 0x0 --rotate normal \
#                     --output VGA1 --off
# xrandr --output LVDS1 --off

# # echo 'new mode'
# # xrandr --newmode "2560x1440_33.00"  162.75  2560 2696 2960 3360  1440 1443 1448 1470 -hsync +vsync
# # echo 'add mode 1'
# # xrandr --addmode DP2 2560x1440_33.00
# # echo 'add mode 2'
# # xrandr --addmode DP3 2560x1440_33.00
# # echo 'dp2'
# # xrandr --output DP2 --mode 2560x1440_33.00
# # echo 'dp3'
# # xrandr --output DP3 --mode 2560x1440_33.00

# #sleep 5;
# echo 'positions'
# #xrandr --output DP1 --off --output DP2 --mode 2560x1440 --pos 0x0 --rotate normal --output DP3 --mode 2560x1440 --pos 2560x0 --rotate normal --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
# #xrandr --output DP3 --mode 2048x1152 --pos 2048x0 --rotate normal --output DP2 --mode 2048x1152 --pos 0x0 --rotate normal --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
# xrandr --output DP3 --primary --mode 2560x1440 --pos 2560x0 --rotate normal --output DP2 --mode 2560x1440 --pos 0x0 --rotate normal --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off

# #potential fix for window buttons on panels not showing on the correct screen
# bash -c 'killall xfce4-panel && xfce4-panel &'
