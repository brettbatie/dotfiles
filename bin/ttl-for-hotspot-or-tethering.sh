#!/bin/bash
sudo mkdir -p /usr/local/lib/sysctl.d
echo "net.ipv4.ip_default_ttl=65" | sudo tee /usr/local/lib/sysctl.d/99-ttl-for-hotspot.conf
echo "net.ipv6.conf.all.hop_limit=65" | sudo tee -a /usr/local/lib/sysctl.d/99-ttl-for-hotspot.conf
