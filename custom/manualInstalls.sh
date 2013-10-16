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
