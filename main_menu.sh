#!/bin/bash

# Nombre del script: arch-install.sh
# Descripción: Este script realiza realiza la instalacion del sistema operativo Arch Linux.
# Autor: Alcides Turruellas
# Fecha: 2024-07-28

# Lista detallada de particiones
# lsblk -o NAME,SIZE,LABEL,FSROOTS,TYPE,PARTTYPENAME | grep -E "part|NAME" | sed 's/├─/\/dev\//' | sed 's/└─/\/dev\//' | sed 's/NAME/   NAME/'

source menu_partitions.sh

# Bucle del menú
while true; do
    clear
    echo "===================================="
    echo " Menu Principal"
    echo "===================================="
    echo
    echo "1. Particionado de discos (cdfisk)"
    echo "2. Seleciona las particiones"
    echo "3. Salir"
    echo "===================================="
    echo
    read -p "Seleccione una opcion: " main_option
    case "$main_option" in
    1) 
	    cfdisk ;;
    2)
        select_partitions ;;
    3) 
        echo "Saliendo..." 
        sleep 1
        break ;;
    *)
        echo "Respuesta inválida. Por favor intenta de nuevo."
        sleep 1 ;;
    esac

done

