#!/bin/bash

# Author: Willian B. Ribeiro  #
# Date: 11/27/2020            #
# OS: Arch Linux              #
###############################

# Lista todos os dispositivos
echo
fdisk -l
echo
read -p "[+] Escolha o dispositivo da lista para instalar o sistema operacional: " ESCOLHA
echo "Dispositivo selecionado: ${ESCOLHA}"
echo

# Criar as partições no disco escolhido a partir do cfdisk
echo "Crie as partições usando o cfdisk"
sleep 2
cfdisk ${ESCOLHA}

# Determina as partições para o boot/raiz/swap
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

# Resumo da criação e do formato de cada partição para o dispositivo escolhido
echo "Resumo da criação e formatação do dispositivo escolhido"
echo " -> BOOT (/BOOT): ${boot_part} com a formatação ${boot_type}"
echo " -> RAÍZ DO SISTEMA (/): ${root_part} com formatação ${root_type}"
echo " -> SWAP: ${swap_part}"
sleep 10
echo

# make filesystem (MKFS) para formatar as partições
mkfs.${boot_type} ${boot_part}
mkfs.${root_type} ${root_part}

# criar e ativa a partição de swap
mkswap ${swap_part}
swapon ${swap_part}

# Montagem do sistema nas partições
mount ${root_part} /mnt
mkdir /mnt/boot /mnt/var /mnt/home
mount ${boot_part} /mnt/boot

# pacstrap para baixar e instalar a base do sistema operacional e programas essenciais
pacstrap /mnt base linux linux-firmware nano dhcpcd net-tools grub sudo git

# Gera o fstab que lista todas as partições de discos disponíveis 
genfstab -U -p /mnt >> /mnt/etc/fstab

# muda a raiz com chroot
arch-chroot /mnt
