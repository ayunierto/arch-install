#!/bin/bash

cd ~/
rm -rf arch-config
git clone https://github.com/ayunierto/arch-config.git
cp -r ~/arch-config/.* ~/

# Instalando gestor de aquetes paru
#
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si
#rm -rf paru/
#paru -S google-chrome

# Instalacion de terminal zsh
sudo pacman -S --noconfirm zsh

# Agregando la terminal zsh al usuario hawk
sudo usermod --shell /usr/bin/zsh $USER

# Plugins para mejorar zsh
sudo pacman -S --noconfirm zsh-syntax-highlighting zsh-autosuggestions # Agregando plugins a zsh

# Instalar locate pra saber ubicacion de los archivos en el sistema
sudo pacman -S --noconfirm locate
sudo updatedb # Actualizar base de datos de locate
sudo mkdir -p /usr/share/zsh-sudo # Agregando carpeta de configuracion para zsh-sudo
sudo chown $USER:$USER /usr/share/zsh-sudo # Cambiando permisos a la carpeta 
cd /usr/share/zsh-sudo
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh # Descargando plugin

# Instalar lsd y bat para mejorar la experiencia de de los comandos ls y cat
sudo pacman -S lsd bat

# Instalacion de powerlevel10k. tema para la terminal zsh
cd ~/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
#'https://github.com/romkatv/powerlevel10k#manual'
# Instalar extencion de vimium para google-chrome

# Instalar fzf para buscar rapidamente archivos. Presionar Ctrl + T para abrir. Ejemplo "cat Ctrl + T".
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#~/.fzf/install



# Agregando tema dracula
sudo git clone https://github.com/dracula/gtk.git /usr/share/themes/Dracula

# Instalar adminsitrador de archivos
sudo pacman -S thunar
