# Install crashplan:
echo 'Need to manually install this application with the following steps:'
echo 'Download/Unzip'
echo 'sudo ./install'
echo 'Note: I had to run the following command to get the crashplan service to automatically start after boot:'
echo 'sudo rm /etc/rc2.d/S99crashplan'
echo 'sudo update-rc.d crashplan defaults'
echo 'Use the following commands so crashplan does not run out of inodes:'
echo '"fs.inotify.max_user_watch=1048576" | sudo tee -a /etc/sysctl.conf'
echo 'sudo sysctl -w fs.inotify.max_user_watches=1048576'
echo ''
echo 'Backup the following directories'
echo '/home'
echo '/opt/'
echo '/usr/local/bin'
echo 'but ignore the directories in /home: .cache, .icedove, .PlayOnLinux, .steam, .VirtualBox, bin, Desktop, Templates, Public, .shotwell, .steampath, .steampid, Documents, Music, Pictures, Videos'
echo ''
echo 'Consider turning off crashplan during business hours to reduce io'
echo 'sudo crontab -e'
echo '0 22 * * * sudo service crashplan start'
echo '0 7  * * * sudo service crashplan stop'