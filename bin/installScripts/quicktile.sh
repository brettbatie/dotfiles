sudo apt-get install python python-gtk2 python-xlib python-dbus python-wnck
sudo mkdir -p /opt/local/quicktile
sudo cd /opt/local/quicktile
sudo git clone https://github.com/ssokolow/quicktile.git .
chown -R brett:brett /opt/local/quicktile
chmod +x setup.py
sudo ./setup.py install