#!/bin/bash

echo
echo "Iniciando o script de pós-instalação"
echo

# atualizar o sistema
echo "Atualizando o sistema"
echo "====================="
sleep 2
sudo apt update && sudo apt upgrade -y
echo

# removendo os programas padrão do ubuntu
echo "Removendo os programas desnecessários"
echo "====================================="
sleep 2
sudo apt remove gnome-software-common xfburn onboard-common xfce4-notes xfce4-notes-plugin mousepad xfce4-screenshooter mate-calc-common atril-common libreoffice-common xfce4-dict simple-scan gimp gimp-data gimp-help-common pidgin pidgin-data pidgin-otr thunderbird thunderbird-locale-en thunderbird-locale-en-us thunderbird-locale-pt thunderbird-locale-pt-br sgt-launcher gnome-mines gnome-sudoku parole gigolo -y
echo

# limpando os pacotes órfãos
echo "limpando os pacotes"
echo "==================="
sleep 2
sudo apt autoclean && sudo apt autoremove -y
echo

#instalando programas
echo "Instalndo programas"
echo "==================="
sleep 2
sudo apt install vlc htop git -y

# instalando a fonte Flat-remix
echo "Instalando o Flat-Remix"
echo "======================="
sleep 2
mkdir projects
cd projects/
git clone https://github.com/daniruiz/flat-remix
git clone https://github.com/daniruiz/flat-remix-gtk
mkdir -p /home/teste/.icons && mkdir -p /home/teste/.themes
cp -r flat-remix/Flat-Remix* /home/teste/.icons/ && cp -r flat-remix-gtk/Flat-Remix-GTK* /home/teste/.themes/
gtk-update-icon-cache /home/teste/.icons/Flat-Remix-Blue-Dark/
echo "Finalizando o programa"
