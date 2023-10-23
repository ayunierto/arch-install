#!/bin/bash
#
ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime
hwclock --systohc
echo "es_PE.UTF-8 UTF-8" > /etc/locale.gen
vim /etc/locale.gen 
locale-gen 
echo "LANG=es_PE.UTF-8" > /etc/locale.conf
echo "laptop" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts 
echo "::1 localhost" >> /etc/hosts 
echo "127.0.0.1 laptop.localhost localhost" >> /etc/hosts 
cat /etc/hosts
passwd 
useradd -m hawk
passwd hawk
usermod -aG wheel hawk
pacman -S sudo
vim /etc/sudoers
pacman -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot
os-prober 
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S networkmanager wpa_supplicant
reboot now
