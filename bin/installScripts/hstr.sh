#!/bin/sh
#ctrl+r history tool found at github.com/dvorka/hstr
wget www.clfh.de/frankh.asc
sudo apt-key add frankh.asc
sudo sh -c 'echo deb http://www.clfh.de/debian wheezy main > /etc/apt/sources.list.d/hstr.list'
sudo sh -c 'echo deb-src http://www.clfh.de/debian wheezy main >> /etc/apt/sources.list.d/hstr.list'
sudo aptitude update
sudo aptitude install hh
