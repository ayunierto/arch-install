#!/bin/bash


echo "A continuacion se formatearan las particiones sda1, sda2, sda3."
echo "Tenga mucha precaucion"
echo "Presiona una tecla para continuar..."
read -n 1 -s

# Formateando particiones
#
mkfs.ext4 /dev/sda2
mkswap /dev/sda3
mkfs.fat -F 32 /dev/sda1

# Montar los sistemas de archivos
#
mount /dev/sda2 /mnt 
mount --mkdir /dev/sda1 /mnt/boot 
swapon /dev/sda3

# Instalacion
#
pacstrap /mnt base linux linux-firmware base-devel neovim  

# Configurar sistema
#
genfstab -U /mnt >> /mnt/etc/fstab 
arch-chroot /mnt
