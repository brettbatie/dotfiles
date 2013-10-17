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