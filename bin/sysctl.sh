#!/bin/bash
sudo mkdir -p /usr/local/lib/sysctl.d
echo "fs.inotify.max_user_watches=1048576" | sudo tee /usr/local/lib/sysctl.d/99-watches.conf
echo "vm.swapiness=10" | sudo tee /usr/local/lib/sysctl.d/99-swapiness.conf
echo "vm.vfs_cache_pressure=50" | sudo tee /usr/local/lib/sysctl.d/99-cache-pressure.conf
sudo sysctl fs.inotify.max_user_watches=1048576
sudo sysctl vm.swappiness=10
sudo sysctl vm.vfs_cache_pressure=50
