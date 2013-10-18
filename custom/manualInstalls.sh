#Install IE Virtual Machines
curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | bash
#Install Glances Monitoring tool
pip install Glances

#Install quicktile
# dependencies
sudo apt-get install python python-gtk2 python-xlib python-dbus python-wnck
mkdir -p /opt/local/quicktile
cd /opt/quicktile
git https://github.com/ssokolow/quicktile.git .
chmod +x setup.py
sudo ./setup.py install


#Icedove plugins, google contacts, iceowl, provider for google calendar, wisestamp

# Install Squirrel SQL by running jar file
http://www.squirrelsql.org/#installation

# Cron
# Creates a list of applications installed on this computer and adds it to source control
* */2 * * * cd $HOME/dotfiles && bin/saveApps desktop-work --quite && git add custom/desktop-work.list && git commit -m "Auto Commit of Application List for Desktop Work" && git push


# Setup Display driver: 
sudo aptitude install fglrx fglrx-control
aticonfig --initial --adapter=all

# Install crashplan:
Download/Unzip
sudo ./install
#Note: I had to run the following command to get the crashplan service to automatically start after boot:
sudo rm /etc/rc2.d/S99crashplan
sudo update-rc.d crashplan defaults

# In Crashplan restore:
# /home
# /opt/
# /usr/local/bin
# but ignore the directories in /home: .cache, .icedove, .PlayOnLinux, .steam, .VirtualBox, bin, Desktop, Templates, Public, .shotwell, .steampath, .steampid, Documents, Music, Pictures, Videos

# NOTE: if restoreing to a temp folder, make sure to cp -af .* to get the hidden directories to merge with the existing ones