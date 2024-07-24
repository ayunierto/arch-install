#!/bin/bash
#
ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime
hwclock --systohc
echo "es_PE.UTF-8 UTF-8" > /etc/locale.gen
nvim /etc/locale.gen 
locale-gen 
echo "LANG=es_PE.UTF-8" > /etc/locale.conf
echo "hawk" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts 
echo "::1 localhost" >> /etc/hosts 
echo "127.0.0.1 laptop.localhost localhost" >> /etc/hosts 
cat /etc/hosts
echo "Clave para el usuario root"
passwd 
useradd -m hawk
echo "Clave para el usuario hawk"
passwd hawk
usermod -aG wheel hawk
nvim /etc/sudoers
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S networkmanager wpa_supplicant
exit
reboot now
