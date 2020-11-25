#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt remove warpinator seahorse redshift-gtk onboard gnote xfce4-taskmanager xed xfce4-screenshooter simple-scan pix drawing hexchat thunderbird rhythmbox celluloid libreoffice-common xfce4-dict baobab -y
sudo apt autoclean && sudo apt autoremove -y
