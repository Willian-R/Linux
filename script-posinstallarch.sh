#!/bin/bash
# Author: Willian B. Ribeiro  #
# Date: 11/27/2020            #
# OS: Arch Linux              #
###############################
echo
read -p "Digite o dispositivo para instalação do GRUB: " ESCOLHA
echo
read -p "Digite o nome da máquina: " nomemaquina
echo
read -p "Digite a senha para o usuário root: " senharoot
echo
read -p "Digite o nome do usuário: " usuario
echo
read -p "Digite a senha para o usuário: " senhausuario
echo
echo pt_BR.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
export LANG=pt_BR.UTF-8
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo ${nomemaquina} > /etc/hostname
systemctl enable dhcpcd
echo "root:${senharoot}" | chpasswd
useradd -m -g users -G wheel -s /bin/bash ${usuario}
echo "${usuario}:${senhausuario}" | chpasswd
echo "${usuario} ALL=(ALL) ALL" >> /etc/sudoers
pacman -S xorg xfce4 xfce4-goodies xdg-user-dirs gvfs lightdm lightdm-gtk-greeter firefox vlc gtkmm3 xf86-video-vmware xf86-input-vmmouse open-vm-tools papirus-icon-theme networkmanager network-manager-applet pulseaudio bash-completion neofetch htop --noconfirm
pacman -Syu --noconfirm
pacman -R xfburn xfce4-sensors-plugin xfce4-notes-plugin mousepad orage xfce4-taskmanager xfce4-clipman-plugin xfce4-screenshooter xfce4-dict parole --noconfirm
pacman -Scc --noconfirm
grub-install ${ESCOLHA}
systemctl enable lightdm
systemctl enable vmtoolsd
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P linux
