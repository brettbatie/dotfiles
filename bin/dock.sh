#!/bin/sh
# #Note: this script runs on boot to help the login manager to use the appropriate monitors. 
# # I modified the file /etc/lightdm/lightdm.conf and added the following line to the [SeatDefaults] section:
# # display-setup-script = /home/brett/dotfiles/bin/dock.sh
#sleep 5
# su - brett -c "/opt/autorandr/./autorandr.py --change"
# su - brett -c "/opt/autorandr/./autorandr.py --load work"
#/opt/autorandr/./autorandr.py --change
/opt/autorandr/./autorandr.py --load work1; 
sleep 4;
/opt/autorandr/./autorandr.py --load work2
