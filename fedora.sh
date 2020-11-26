#!/bin/bash
sudo dnf check-update
sudo dnf upgrade -y
sudo dnf remove xfburn seahorse mousepad orage xfce4-clipman galculator xfce4-screenshooter geany atril gnumeric xfce4-dict claws-mail pidgin parole pragha asunder -y
sudo dnf autoremove -y
sudo dnf install htop neofetch -y
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install vlc -y
