#!/bin/bash
echo deb http://deb.debian.org/debian bullseye main > /etc/apt/sources.list
echo deb http://deb.debian.org/debian bullseye-updates main >> /etc/apt/sources.list
sudo apt update
sudo apt full-upgrade -y
sudo apt autoclean && sudo apt autoremove -y
systemctl reboot
