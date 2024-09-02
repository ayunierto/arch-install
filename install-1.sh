#!/bin/bash


echo "A continuacion se formatearan las particiones sda3, sda4, sda7."
echo "Tenga mucha precaucion"
echo "Presiona una tecla para continuar..."
read -n 1 -s

# Utilizar cfdisk para particionar 
# Formateando particiones
# para crear pariticiones utilizar el comando cfdisk
# crear una partición de 1G como EFI System
# crear una partición del tamaño de la memoria ram tipo Linux Swap
# crear una particion con el tamaño deseado para el sistema como Linux filesystem 

mkfs.ext4 /dev/sda7
mkswap /dev/sda6
mkfs.fat -F 32 /dev/sda5

# Montar los sistemas de archivos
#
mount /dev/sda7 /mnt 
mount --mkdir /dev/sda5 /mnt/boot 
swapon /dev/sda6

# Instalacion
#
pacstrap /mnt base linux linux-firmware base-devel neovim  

# Configurar sistema
#
genfstab -U /mnt >> /mnt/etc/fstab 
arch-chroot /mnt
