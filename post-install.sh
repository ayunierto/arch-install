#!/bin/bash
#
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
sudo rm -rf /usr/share/zsh-sudo/ #Eliminado el directorio en caso de que existiera
sudo mkdir -p /usr/share/zsh-sudo # Agregando carpeta de configuracion para zsh-sudo
sudo chown $USER:$USER /usr/share/zsh-sudo # Cambiando permisos a la carpeta 
cd /usr/share/zsh-sudo
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh # Descargando plugin

# Instalar locate pra saber ubicacion de los archivos en el sistema
sudo pacman -S --noconfirm locate
sudo updatedb # Actualizar base de datos de locate
# Instalar lsd y bat para mejorar la experiencia de de los comandos ls y cat
# Se agregaron aliases en la configuracion de la zsh para remplazar ls y cat por lsd y bat
sudo pacman -S --noconfirm lsd bat

# Instalacion de powerlevel10k. tema para la terminal zsh
# la configuracion ya esta agregada en el archivo .zshrc
cd ~/
rm -rf ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
#'https://github.com/romkatv/powerlevel10k#manual'

# Instalar fzf para buscar rapidamente archivos. Presionar Ctrl + T para abrir. Ejemplo "cat Ctrl + T".
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Agregando tema dracula
rm -rf ~/.themes
mkdir -p ~/.themes
cd ~/.themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
mv gtk-master Dracula
rm master.zip

# Instalar adminsitrador de archivos
sudo pacman -S --noconfirm thunar

git config --global credential.helper cache

cd ~/
rm -rf ~/arch-config
git clone https://github.com/ayunierto/arch-config.git
cp -rf ~/arch-config/.* ~/

sudo pacman -S vlc --noconfirm
