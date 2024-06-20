#!/bin/bash


echo "A continuacion se formatearan las particiones sda5, sda6."
echo "Tenga mucha precaucion"
echo "Presiona una tecla para continuar..."
read -n 1 -s

# Utilizar cfdisk para particionar 
# Formateando particiones
#
mkfs.ext4 /dev/sda6
#mkswap /dev/sda3
mkfs.fat -F 32 /dev/sda5

# Montar los sistemas de archivos
#
mount /dev/sda6 /mnt 
mount --mkdir /dev/sda5 /mnt/boot 
#swapon /dev/sda3

# Instalacion
#
pacstrap /mnt base linux linux-firmware base-devel vim  

# Configurar sistema
#
genfstab -U /mnt >> /mnt/etc/fstab 
arch-chroot /mnt
