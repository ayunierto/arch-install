#!/bin/bash
# Script para la instalacion de arch linux con gestor de ventanas awesome
# e inicio de sesion con LightDM

sudo pacman -Syu	# Actualizar sistema
sudo pacman -S --noconfirm awesome    # Instalar gestor de ventanas

# Instalar editor y terminal
sudo pacman -S --noconfirm kitty nvim

# Instalando algunos paquetes necesarios
sudo pacman -S --noconfirm zip unzip tar p7zip base-devel alsa-utils pulseaudio pulseaudio-alsa pavucontrol

mkdir -p ~/.config/awesome  # Crea el directorio de config
cp /etc/xdg/awesome/rc.lua ~/.config/awesome # Copia la config

# Establece la terminal kitty y el editor nvim por defecto en awesome
sed -i 's/terminal = "xterm"/terminal = "kitty"/g' ~/.config/awesome/rc.lua
sed -i 's/nano/nvim/g' ~/.config/awesome/rc.lua 

# Instalar gestor de sesiones
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm   # Habilita el gestor

# Instalar una terminal en este caso kitty
sudo pacman -S --noconfirm kitty
mkdir -p ~/.config/kitty
echo 'font_size 11' > ~/.config/kitty.conf
