#!/bin/bash
# Script para la instalacion de arch linux con gestor de ventanas awesome
# e inicio de sesion con LightDM

sudo pacman -S --noconfirm awesome    # Instalar gestor de ventanas

mkdir -p ~/.config/awesome  # Crea el directorio de config
cp /etc/xdg/awesome/rc.lua ~/.config/awesome # Copia la config

# Instalar gestor de sesiones
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm   # Habilita el gestor

# Instalar una terminal en este caso kitty
sudo pacman -S --noconfirm kitty
