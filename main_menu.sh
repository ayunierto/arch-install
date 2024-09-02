#!/bin/bash
# Nombre del script: arch-install.sh
# Descripción: Este script realiza realiza la instalacion del sistema operativo Arch Linux.
# Autor: Alcides Turruellas
# Fecha: 2024-07-28

# Lista detallada de particiones
# lsblk -o NAME,SIZE,LABEL,FSROOTS,TYPE,PARTTYPENAME | grep -E "part|NAME" | sed 's/├─/\/dev\//' | sed 's/└─/\/dev\//' | sed 's/NAME/   NAME/'


verificar_conexion() {
    if nmcli -t -f ACTIVE,DEVICE,TYPE,CONNECTION d | grep '^yes' &> /dev/null; then
        echo "Conexión a Internet detectada."
        sleep 1
    else
        echo "No hay conexión a Internet."
        echo
        conectar_wifi
    fi
}

conectar_wifi() {
    echo "Buscando redes WiFi disponibles..."
    nmcli -f SSID dev wifi list

    read -p "Introduce el nombre de la red WiFi a la que deseas conectarte: " red_wifi
    read -sp "Introduce la contraseña para la red '$red_wifi': " contraseña
    echo
  
    # Intenta conectar a la red WiFi especificada
    echo "Intentando conectarse a '$red_wifi'..."
    nmcli device wifi connect "$red_wifi" password "$contraseña"
    
    # Verifica si la conexión fue exitosa
    if nmcli -t -f ACTIVE,DEVICE,TYPE,CONNECTION d | grep '^yes' &> /dev/null; then
        echo "Conexión a Internet establecida exitosamente."
    else
        echo "No se pudo conectar a la red WiFi. Por favor, verifica la contraseña y el nombre de la red."
        sleep 3
        exit
    fi
}

verificar_conexion

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
        menu_partitions ;;
    3) 
        echo "Saliendo..." 
        sleep 1
        break ;;
    *)
        echo "Respuesta inválida. Por favor intenta de nuevo."
        sleep 1 ;;
    esac

done

