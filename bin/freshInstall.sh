#!/bin/bash

echo 'Removing CD-Rom from sources list'
echo 'Enter root password'
su -c 'perl -p -i -e "s/^deb cdrom/#deb cdrom/" /etc/apt/sources.list' root

echo "Installing GIT & sudo"
echo "Enter root password"
su -c 'aptitude install git sudo' root

echo "Updating aptitude sources"
echo "Enter root password"
su -c 'aptitude update'

groups=`groups`
if [[ "$groups" != *sudo* ]]; then
    echo 'Adding user to sudo group'
    echo 'Enter root passsword'
    user=$(whoami)
    su -c "usermod -a -G sudo $user" root
    echo "Now logoff and login again. Then restart this script"
    exit
fi

echo "Setup dotfiles"
bash <(wget -nv -O - https://raw.github.com/brettbatie/dotfiles/master/bin/dotm)
source ~/.bashrc

echo "Setup private dotfiles"
USER_HOME=$(eval echo ~${SUDO_USER})
dotm -d $USER_HOME/dotfiles-private/ -r ssh://brett@brettip.mooo.com:2000/home/brett/.git/dotfiles-private.git
source ~/dotfiles-private/source/50_aliases.sh
chmod 600 ~/dotfiles-private/.ssh/id_rsa

echo 'Adding contrib & non-free to sources.list'
sudo perl -p -i -e 's/^(deb((?!contrib).)*)$/\1 contrib/g' /etc/apt/sources.list
sudo perl -p -i -e 's/^(deb((?!non-free).)*)$/\1 non-free/g' /etc/apt/sources.list


sudo dpkg --add-architecture i386

echo 'Installing x2go'
echo 'deb http://packages.x2go.org/debian wheezy main' | sudo tee /etc/apt/sources.list.d/x2go.list
echo 'deb-src http://packages.x2go.org/debian wheezy main' | sudo tee -a /etc/apt/sources.list.d/x2go.list
sudo aptitude install x2go-keyring

echo 'Installing Sublime 3052'
wget -O /tmp/sublime.deb http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb
sudo dpkg -i /tmp/sublime.deb

sudo aptitude update

installApps desktop-work.list

echo "Installing QuickTile"
# sudo apt-get install python python-gtk2 python-xlib python-dbus python-wnck
sudo mkdir -p /opt/local/quicktile
cd /opt/local/quicktile
sudo git clone git@github.com:brettbatie/quicktile.git .
sudo chmod +x setup.py
sudo ./setup.py install
cd ~


echo "Installing SquirrelSQL"
wget -O squirrelsql.jar http://downloads.sourceforge.net/project/squirrel-sql/1-stable/3.5.0/squirrel-sql-3.5.0-install.jar?r=http%3A%2F%2Fwww.squirrelsql.org%2F&ts=1388377513&use_mirror=    softlayer-ams
java -jar squirrelsql.jar
rm squirrelsql.jar

echo "Installing Camdesk"
sudo mkdir -p /opt/local/CamDesk
cd /opt/local/CamDesk
sudo wget -O camdesk.tar.gz http://downloads.sourceforge.net/project/camdesk/camdesk-1.0-for-linux2.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fcamdesk%2F&ts=1388377614&use_mirror=softl    ayer-dal
sudo tar -xvzf camdesk-1.0-for-linux2.tar.gz
sudo rm camdesk.tar.gz
cd ~



echo "Still need to install Crashplan"
 # Crashplan watches a lot of inodes
echo "fs.inotify.max_user_watches=1048576" | sudo tee -a /etc/sysctl.conf
sudo sysctl -w fs.inotify.max_user_watches=1048576






