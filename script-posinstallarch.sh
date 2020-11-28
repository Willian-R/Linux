#!/bin/bash
echo pt_BR.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
export LANG=pt_BR.UTF-8
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
read -p "Digite o nome da máquina: " nomemaquina
echo ${nomemaquina} > /etc/hostname
systemctl enable dhcpcd
read -p "Digite a senha para o usuário root: " senharoot
echo "root:${senharoot}" | chpasswd
read -p "Digite o nome do usuário: " usuario
useradd -m -g users -G wheel -s /bin/bash ${usuario}
read -p "Digite a senha para o usuário: " senhausuario
echo "${usuario}:${senhausuario}" | chpasswd
echo "${usuario} ALL=(ALL) ALL" >> /etc/sudoers
pacman -S xorg xfce4 xfce4-goodies xdg-user-dirs gvfs lightdm lightdm-gtk-greeter firefox vlc gtkmm3 xf86-video-vmware xf86-input-vmmouse open-vm-tools papirus-icon-theme networkmanager network-manager-applet pulseaudio bash-completion htop --noconfirm
pacman -Syu --noconfirm
pacman -R xfburn xfce4-sensors-plugin xfce4-notes-plugin mousepad orage xfce4-taskmanager xfce4-clipman-plugin xfce4-screenshooter xfce4-dict parole --noconfirm
pacman -Scc --noconfirm
read "Digite o dispositivo para instalação do GRUB: " ESCOLHA
grub-install ${ESCOLHA}
systemctl enable lightdm
systemctl enable vmtoolsd
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P linux
