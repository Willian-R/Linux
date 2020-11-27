#!/bin/bash

fdisk -l
echo
read -p "[+] Escolha o dispositivo da lista para instalar o sistema operacional: " ESCOLHA
echo "Dispositivo selecionado: ${ESCOLHA}"
echo
echo "Crie as partições usando o cfdisk"
sleep 2
cfdisk ${ESCOLHA}
read -p "Número da partição de boot:" a
boot_part=${ESCOLHA}${a}
read -p "Tipo do formato da partição: " a
boot_type=${a}
read -p "Número da partição de swap: " a
swap_part=${ESCOLHA}${a}
read -p "Número da partição raíz: " a
root_part=${ESCOLHA}${a}
read -p "Tipo de formato da partição: " a
root_type=${a}
echo
echo "Resumo da criação e formatação do dispositivo escolhido"
echo " -> BOOT (/BOOT): ${boot_part} com a formatação ${boot_type}"
echo " -> RAÍZ DO SISTEMA (/): ${root_part} com formatação ${root_type}"
echo " -> SWAP: ${swap_part}"
echo
mkfs.${boot_type} ${boot_part}
mkfs.${root_type} ${root_part}
mkswap ${swap_part}
swapon ${swap_part}
mount ${root_part} /mnt
mkdir /mnt/boot /mnt/var /mnt/home
mount ${boot_part} /mnt/boot
pacstrap /mnt base linux linux-firmware nano dhcpcd net-tools grub sudo
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
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
read -p "Digite o nome do usuário" usuario
useradd -m -g users -G wheel -s /bin/bash ${usuario}
read -p "Digite a senha para o usuário: " senhausuario
echo "${usuario}:${senhausuario}" | chpasswd
echo ${usuario} ALL=(ALL) ALL >> /etc/sudoers
pacman -S xorg xfce4 xfce4-goodies xdg-user-dirs gvfs lightdm lightdm-gtk-greeter firefox vlc gtkmm3 xf86-video-vmware xf86-input-vmmouse open-vm-tools papirus-icon-theme --noconfirm
grub-install ${ESCOLHA}
systemctl enable lightdm
systemctl enable vmtoolsd
grub-mkconfig -o /boot/grub/grub.cfg
mkinitcpio -P linux
exit
