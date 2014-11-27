sudo apt-get install python python-gtk2 python-xlib python-dbus python-wnck
sudo mkdir -p /opt/quicktile
cd /opt/quicktile
sudo git clone https://github.com/brettbatie/quicktile .
chown -R brett:brett /opt/local/quicktile
chmod +x setup.py
sudo ./setup.py install
