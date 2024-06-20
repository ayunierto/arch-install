#!/bin/bash


echo "A continuacion se formatearan las particiones sda3, sda4, sda7."
echo "Tenga mucha precaucion"
echo "Presiona una tecla para continuar..."
read -n 1 -s

# Utilizar cfdisk para particionar 
# Formateando particiones
#
mkfs.ext4 /dev/sda7
mkswap /dev/sda4
mkfs.fat -F 32 /dev/sda3

# Montar los sistemas de archivos
#
mount /dev/sda7 /mnt 
mount --mkdir /dev/sda3 /mnt/boot 
swapon /dev/sda4

# Instalacion
#
pacstrap /mnt base linux linux-firmware base-devel vim  

# Configurar sistema
#
genfstab -U /mnt >> /mnt/etc/fstab 
arch-chroot /mnt
