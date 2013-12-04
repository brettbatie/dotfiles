# Add sudo to user (if needed)
su root
usermod -a -G sudo userName

# Home computer needs the realtek driver for it's wifi
sudo aptitude install firmware-realteK

# Add additional sources (like non free for fglrx driver)
sed -i 's/ main/ main contrib non-free/g' /etc/apt/sources.list
sudo aptitude update

# Install fglrx for ati/amd video cards
aptitude -r install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') fglrx-driver fglrx-control
sudo aticonfig --initial
shutdown -r now

#Install IE Virtual Machines
curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | bash
#Install Glances Monitoring tool
sudo pip install Glances

#Install quicktile
# dependencies
sudo apt-get install python python-gtk2 python-xlib python-dbus python-wnck
mkdir -p /opt/local/quicktile
cd /opt/local/quicktile
git clone https://github.com/ssokolow/quicktile.git .
chmod +x setup.py
sudo ./setup.py install


#Icedove plugins, google contacts, iceowl, provider for google calendar, wisestamp

# Install Squirrel SQL by running jar file
http://www.squirrelsql.org/#installation

# Cron
# Creates a list of applications installed on this computer and adds it to source control
* */2 * * * cd $HOME/dotfiles && bin/saveApps desktop-work --quite && git add custom/desktop-work.list && git commit -m "Auto Commit of Application List for Desktop Work" && git push


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


# Crashplan watches a lot of inodes
echo "fs.inotify.max_user_watch=1048576" | sudo tee -a /etc/sysctl.conf
sudo sysctl -w fs.inotify.max_user_watches=1048576

# Sublime Text
Download @ http://www.sublimetext.com/3
sudo dpkg -i sublime-text_build-3047_amd64.deb

# Squirrel SQL
Download @ http://squirrel-sql.sourceforge.net/#installation
java -jar squirrel-sql-3.5.0-install.jar

# Cam Desk
Download @ http://sourceforge.net/projects/camdesk/

# Turn off crashplan during business hours to reduce IO
sudo crontab -e
0 22 * * * sudo service crashplan start
0 7  * * * sudo service crashplan stop

# Install yuuguu for screensharing (make sure to download the correct architecture 32/64 bit)
dpkg -i yuuguu_latest*.deb
# if errors about java, make sure java is in the path and then do a 
dpkg -i --force-depends yuuguu_latest_i386.deb

