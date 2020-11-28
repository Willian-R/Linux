#!/bin/bash

###############################
# Author: Willian B. Ribeiro  #
# Date: 11/22/2020            #
# OS: GNU/Linux Debian        #
###############################

echo deb http://deb.debian.org/debian bullseye main > /etc/apt/sources.list
echo deb http://deb.debian.org/debian bullseye-updates main >> /etc/apt/sources.list
sudo apt update
sudo apt full-upgrade -y
sudo apt autoclean && sudo apt autoremove -y
sudo apt remove xfburn xfce4-sensors-plugin mousepad xfce4-taskmanager xfce4-clipman xfce4-screenshooter atril libreoffice-common xfce4-dict xsane hv3 parole quodlibet gcc-8-base exfalso
sudo apt autoclean && sudo apt autoremove -y
sudo apt install vlc transmission-gtk papirus-icon-theme
systemctl reboot
