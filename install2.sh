    1  ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime
    2  hwclock --systohc
    3  nvim /etc/locale.gen 
    4  locale-gen 
    5  echo "LANG=es_PE.UTF-8" > /etc/locale.conf
    6  echo "laptop" > /etc/hostname
    7  echo "127.0.0.1 localhost" >> /etc/hosts 
    8  echo "::1 localhost" >> /etc/hosts 
    9  echo "127.0.0.1 laptop.localhost localhost" >> /etc/hosts 
   10  cat /etc/hosts
   11  passwd 
   12  useradd -m hawk
   13  passwd hawk
   14  usermod -aG wheel hawk
   15  pacman -S sudo
   16  nvim /etc/sudoers
   17  pacman -S grub efibootmgr os-prober
   18  grub-install --target=x86_64-efi --efi-directory=/boot
   19  os-prober 
   20  grub-mkconfig -o /boot/grub/grub.cfg
   21  pacman -S networkmanager wpa_supplicant
   22  history
   23  history >> /home/install2.sh
