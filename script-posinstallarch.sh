#!/bin/bash

###############################
# Author: Willian B. Ribeiro  #
# Date: 11/27/2020            #
# OS: Arch Linux              #
###############################

# instalação GRUB, nome da máquina, senha root, nome do usuário e senha do usuário
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

# Determina o idioma português-brasileiro para o sistema
echo pt_BR.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
export LANG=pt_BR.UTF-8

# Determina o fuso horário de São Paulo
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Sincroniza a hora da placa-mãe com o sistema operacional
hwclock --systohc

# Nome da máquina
echo ${nomemaquina} > /etc/hostname
systemctl enable dhcpcd

# senha para o root
echo "root:${senharoot}" | chpasswd

# cria o usuário, senha e adiciona na lista de sudo
useradd -m -g users -G wheel -s /bin/bash ${usuario}
echo "${usuario}:${senhausuario}" | chpasswd
echo "${usuario} ALL=(ALL) ALL" >> /etc/sudoers

# Instalação dos programas - Ambiente Gráfico: xfce | Diplay manager: lightdm | Gerenciar diretórios do usuário: xdg-user-dirs |
pacman -S xorg xfce4 xfce4-goodies xdg-user-dirs gvfs lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings firefox vlc gtkmm3 xf86-video-vmware xf86-input-vmmouse open-vm-tools papirus-icon-theme networkmanager network-manager-applet pulseaudio bash-completion neofetch --noconfirm

# Atualização do sistema
pacman -Syu --noconfirm

# Desinstala programas desnecessários
pacman -R xfburn xfce4-sensors-plugin xfce4-notes-plugin mousepad orage xfce4-clipman-plugin xfce4-screenshooter xfce4-dict parole --noconfirm

# Apaga o cache do pacman
pacman -Scc --noconfirm

# Ativa vmtools (para o vmware) e o lightdm
systemctl enable lightdm
systemctl enable vmtoolsd

# Instala o grub
grub-install ${ESCOLHA}
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P linux
