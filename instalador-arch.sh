#!/bin/bash

##############################################
# Author: Willian B. Ribeiro                 #
# Date: 11/28/2020                           #
# OS: Arch Linux                             #
# Description: simple installer - Arch Linux #
##############################################

# Banner
tput bold; echo "============================";
tput setaf 6; echo "   Instalador Arch Linux"; tput sgr0;
tput bold; echo "============================"; tput sgr0;
echo

# Lista de todos os dispositivos na máquina e realiza a escolha do usuário
tput bold; tput setaf 11; echo "----> Lista de dispositivos";
tput setaf 11; echo "======================================="; tput sgr0;
echo
fdisk -l
echo
tput bold; read -p "Escolha um dispositivo: " DISP;
echo
tput setaf 1; echo "Dispositivo selecionado: ${DISP}"; tput sgr0;
sleep 5

# Cria as partições no local de armazenamento escolhido a partir do cfdisk
cfdisk ${DISP}
clear

# Pergunta ao usuário as partições e formato para a formatação
read -p "Foi escolhido swap? [s/n] " SE
read -p "Partição para boot: " BOOT_PART
read -p "Formato da partição: " BOOT_FORM
read -p "Partição para raíz do sistema: " ROOT_PART
read -p "Formato da partição: " ROOT_FORM

# resumo da criação e do formato de cada partição no dispositivo escolhido
clear
tput bold; tput setaf 6; echo "Resumo da criação e formatação do dispositivo escolhido"; tput sgr0;
tput bold; tput setaf 7; echo " -----> BOOT (/BOOT): ${DISP}${BOOT_PART} com a formatação ${BOOT_FORM}"
echo " -----> RAÍZ DO SISTEMA (/): ${DISP}${ROOT_PART} com formatação ${ROOT_FORM}"
if [ ${SE} = "s" ]; then
	echo " -----> SWAP: ${DISP}${swap_part}"
fi
tput sgr0;
sleep 5
echo

# Formata as partições escolhidas e ativa o swap
mkfs.${BOOT_FORM} ${DISP}${BOOT_PART}
mkfs.${ROOT_FORM} ${DISP}${ROOT_PART}
if [ ${SE} = "s" ];then
	read -p "Partição para swap: " SWAP_PART
	mkswap ${DISP}${SWAP_PART}
	swapon ${DISP}${SWAP_PART}
fi

# montagem do sistema nas partições
mount ${DISP}${ROOT_PART} /mnt
mkdir /mnt/boot /mnt/home /mnt/var
mount ${DISP}${BOOT_PART} /mnt/boot
echo

# instalando a base do sistema com pacstrap
tput bold; tput setaf 1; echo "Escolha um tipo de kernel linux"; tput sgr0;
echo
tput bold; echo "1) Stable - Kernel e módulos Vanilla Linux, com algus patches aplicados"
echo "2) Hardened - Um kernel focado em segurança para mitigar explorações de kernel"
echo "3) Longterm - Kernel e módulos Linux com suporte de longo prazo (LTS)"
echo "4) Zen Kernel - Resultado de um esforço colaborativo para fornecer o melhor kernel Linux possível para os sistemas do dia a dia"
echo
read -p "Escolha uma opção de kernel: " OPC
case ${OPC} in

1)
KERNEL=$"linux";;

2)
KERNEL=$"linux-hardened";;

3)
KERNEL=$"linux-lts";;

4)
KERNEL=$"linux-zen";;

esac
pacstrap /mnt base ${KERNEL} linux-firmware nano dhcpcd net-tools sudo git grub

# Gerando o fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

# mudando a raíz com chroot
arch-chroot /mnt
