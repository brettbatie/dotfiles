#!/bin/bash

echo "Installing GIT & sudo"
echo "Enter root password"
su -c 'aptitude install git sudo' root

groups=`groups`
if [[ "$groups" != *sudo* ]]; then
    echo 'Adding user to sudo group'
    echo 'Enter root passsword'
    user=$(whoami)
    su -c "usermod -a -G sudo $user" root
    echo "Now logoff and login again. Then restart this script"
    exit
fi

echo 'Removing CD-Rom from sources list'
echo 'Enter root password'
sudo perl -p -i -e "s/^deb cdrom/#deb cdrom/" /etc/apt/sources.list

echo "Updating aptitude sources"
echo "Enter root password"
sudo aptitude update

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

