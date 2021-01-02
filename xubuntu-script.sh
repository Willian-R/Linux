#!/bin/bash

echo
echo "Iniciando o script de pós-instalação"
echo

# atualizar o sistema
echo "Atualizando o sistema"
echo "====================="
sleep 1
sudo apt update && sudo apt upgrade -y
echo

# removendo os programas padrão do ubuntu
echo "Removendo os programas desnecessários"
echo "====================================="
sleep 1
sudo apt remove gnome-software-common xfburn onboard-common xfce4-notes xfce4-notes-plugin mousepad xfce4-screenshooter mate-calc-common atril-common libreoffice-common xfce4-dict simple-scan gimp gimp-data gimp-help-common pidgin pidgin-data pidgin-otr thunderbird thunderbird-locale-en thunderbird-locale-en-us thunderbird-locale-pt thunderbird-locale-pt-br sgt-launcher gnome-mines gnome-sudoku parole gigolo -y
echo

# limpando os pacotes órfãos
echo "limpando os pacotes"
echo "==================="
sleep 1
sudo apt autoclean && sudo apt autoremove -y
echo
