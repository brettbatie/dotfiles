#!/bin/bash

line="* */2 * * * cd $HOME/dotfiles && bin/saveApps desktop-work --quite && git add custom/desktop-work.list && git commit -m 'Auto Commit of Application List for Desktop Work' && git push"
(crontab -u brett -l; echo "$line") | crontab -u brett -
