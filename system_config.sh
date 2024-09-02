#!/bin/bash

system_config() {
	genfstab -U /mnt >> /mnt/etc/fstab
	arch-chroot /mnt /bin/bash -c "ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime"
	arch-chroot /mnt /bin/bash -c "hwclock --systohc"
	arch-chroot /mnt /bin/bash -c "echo 'es_PE.UTF-8 UTF-8' > /etc/locale.gen"
	arch-chroot /mnt /bin/bash -c "locale-gen" 
	arch-chroot /mnt /bin/bash -c "echo 'LANG=es_PE.UTF-8' > /etc/locale.conf"
	
	read -p "Nombre para la pc (hostname): " hostname

	arch-chroot /mnt /bin/bash -c "echo '$hostname' > /etc/hostname"
	arch-chroot /mnt /bin/bash -c "echo '127.0.0.1 localhost' >> /etc/hosts"
	arch-chroot /mnt /bin/bash -c "echo '::1 localhost' >> /etc/hosts"
	arch-chroot /mnt /bin/bash -c "echo '127.0.0.1 $hosname.localhost localhost' >> /etc/hosts"

	echo -n "Ingrese la clave para el usuario root: "
	arch-chroot /mnt /bin/bash -c "passwd"

	read -p "Nombre de usuario a crear: " username
	arch-chroot /mnt /bin/bash -c "useradd -m $username"

	echo "Clave para el usuario $username"
	arch-chroot /mnt /bin/bash -c "passwd $username"
	arch-chroot /mnt /bin/bash -c "usermod -aG wheel $username"
	
	arch-chroot /mnt /bin/bash -c "echo '%wheel All=(ALL:ALL) ALL' >> /etc/sudoers"

	arch-chroot /mnt /bin/bash -c "pacman -S --noconfirm grub efibootmgr os-prober ntfs-3g"
	arch-chroot /mnt /bin/bash -c "echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub"
	arch-chroot /mnt /bin/bash -c "grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB"
	arch-chroot /mnt /bin/bash -c "os-prober"
	arch-chroot /mnt /bin/bash -c "grub-mkconfig -o /boot/grub/grub.cfg"
	
	
	# habilitando conexión a internet
	arch-chroot /mnt /bin/bash -c "pacman -S --noconfirm networkmanager wpa_supplicant"
	arch-chroot /mnt /bin/bash -c "systemctl enable NetworkManager"
	arch-chroot /mnt /bin/bash -c "systemctl start NetworkManager"

	# Entorno de escritorio
	arch-chroot /mnt /bin/bash -c "pacman -Syu"
	# Instalar gestor de ventanas y de inicio de sesion
	arch-chroot /mnt /bin/bash -c "pacman -S --noconfirm awesome lightdm lightdm-gtk-greeter"
	arch-chroot /mnt /bin/bash -c "systemctl enable lightdm"

	# Instalando audio
	arch-chroot /mnt /bin/bash -c "pacman -S --noconfirm alsa-utils pulseaudio pulseaudio-alsa pavucontrol"
	arch-chroot /mnt /bin/bash -c "usermod -aG audio $username"
	
	arch-chroot /mnt /bin/bash -c "pacman -S --noconfirm kitty neofetch zip unzip tar p7zip wget zsh zsh-syntax-highlighting zsh-autosuggestions lsd bat neovim firefox"
	arch-chroot /mnt /bin/bash -c "usermod --shell /usr/bin/zsh $username"
 	arch-chroot /mnt /bin/bash -c "git clone https://github.com/NvChad/starter ~/.config/nvim && nvim"

  	
   

}
