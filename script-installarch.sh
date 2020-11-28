#!/bin/bash

# Author: Willian B. Ribeiro  #
# Date: 11/27/2020            #
# OS: Arch Linux              #
###############################

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
pacstrap /mnt base linux linux-firmware nano dhcpcd net-tools grub sudo git
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
