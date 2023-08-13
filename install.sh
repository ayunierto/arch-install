#!/bin/bash
# Script para la instalacion de arch linux con gestor de ventanas awesome
# e inicio de sesion con LightDM

# Conectandose a internet
sudo systemctl enable NetworkManager 
sudo systemctl start NetworkManager
nmcli device wifi connect "Net05" password "A&B&Dios"

# Actualizando sistema
#
sudo pacman -Syu

# Instalar gestor de ventanas y de inicio de sesion
#
sudo pacman -S --noconfirm awesome
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm
echo "exec awesome" >> ~/.xinitrc

# Configurando gestor de ventanas
#
mkdir ~/.config/awesome
#cp /etc/xdg/awesome/rc.lua ~/.config/awesome/		# Copiando configuracion por defecto
#cp /usr/share/awesome/themes/default/theme.lua ~/.config/awesome/	# Copiando tema por defecto
#sed -i 's/terminal = "xterm"/terminal = "kitty"/g' ~/.config/awesome/rc.lua	#cambiando terminal por defecto
#sed -i 's/nano/nvim/g' ~/.config/awesome/rc.lua
#sed -i "s#beautiful\.init(gears\.filesystem\.get_themes_dir() \.\. \"default/theme\.lua\")#beautiful.init(\"$HOME/.config/awesome/theme.lua\")#g" ~/.config/awesome/rc.lua	# Cambiando ubicacion de tema por defecto

# Instalando audio
#
sudo pacman -S --noconfirm alsa-utils pulseaudio pulseaudio-alsa pavucontrol
sudo usermod -aG audio hawk

# Instalando algunos paquetes necesarios
#
sudo pacman -S --noconfirm kitty git neofetch base-devel man
mkdir -p ~/.config/kitty
#echo 'font_size 11' > ~/.config/kitty.conf

# Instalando gestor de aquetes paru
#
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
rm -rf paru/
paru -S google-chrome

# Instalando algunos paquetes necesarios
sudo pacman -S --noconfirm zip unzip tar p7zip 



