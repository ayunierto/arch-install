#!/bin/bash

# Nombre del script: arch-install.sh
# Descripción: Este script realiza realiza la instalacion del sistema operativo Arch Linux.
# Autor: Alcides Turruellas
# Fecha: 2024-07-28

# Lista detallada de particiones
# lsblk -o NAME,SIZE,LABEL,FSROOTS,TYPE,PARTTYPENAME | grep -E "part|NAME" | sed 's/├─/\/dev\//' | sed 's/└─/\/dev\//' | sed 's/NAME/   NAME/'

clear
# Obtener las particiones
string=$(echo $(lsblk | grep 'part' | sed 's/├─//g' | sed 's/└─//g' | awk '{print $1}'))

# Convertir la lista de particiones en un array
IFS=' ' read -r -a options <<<"$string"
options+=("Volver al menu principal")

list_partitions() {
    clear
    echo "============================="
    echo " Seleccione las particiones"
    echo "============================="

    # Mostrar lista de particiones
    for i in "${!options[@]}"; do
        echo "$((i + 1)). ${options[$i]}"
    done
    echo "============================="
    echo
}
# Bucle del menú
while true; do
    clear
    echo "============================="
    echo " Menu Principal"
    echo "============================="
    echo
    echo "1. Particionado de discos"
    echo "============================="
    echo
    read -p "Seleccione una opcion: " main_option
    case "$main_option" in
    1) sudo cfdisk ;;
    2) echo '' ;;
    *)
        echo "Respuesta inválida. Por favor intenta de nuevo."
        sleep 2
        ;;
    esac

    # =================================================================
    # Primera peticion
    # Particion raiz '/'
    # =================================================================
    while true; do
        list_partitions
        read -p "Selecciona la particion para la raiz del sistema '/' [1-${#options[@]}]: " root_part

        # Validar la opción ingresada
        if [[ $root_part -ge 1 && $root_part -le ${#options[@]} ]]; then
            if [[ $root_part -eq ${#options[@]} ]]; then
                clear
                echo "Volver..."
                break 2
            fi

            # Decrementando en 1 para que coincida con el indice del arreglo
            root_part=$((root_part - 1))
            # Elminar la particion seleccionada del array de opciones
            new_array=()
            for ((i = 0; i < ${#options[@]}; i++)); do
                if [ $i -ne $root_part ]; then
                    new_array+=("${options[$i]}")
                fi
            done

            # Reemplazar el array original con el nuevo
            options=("${new_array[@]}")

            # =================================================================
            # Segunda peticion
            # Particion boot '/boot'
            # =================================================================
            while true; do
                list_partitions
                read -p "Selecciona la particion para el arranque '/boot' [1-${#options[@]}]: " boot_part

                # Validar la opción ingresada
                if [[ $boot_part -ge 1 && $boot_part -le ${#options[@]} ]]; then
                    if [[ $boot_part -eq ${#options[@]} ]]; then
                        echo "Volver"
                        break 3
                    fi

                    # Decrementando en 1 para que coincida con el indice del arreglo
                    boot_part=$((boot_part - 1))
                    # Elminar la particion seleccionada del array de opciones
                    new_array=()
                    for ((i = 0; i < ${#options[@]}; i++)); do
                        if [ $i -ne $boot_part ]; then
                            new_array+=("${options[$i]}")
                        fi
                    done

                    # Reemplazar el array original con el nuevo
                    options=("${new_array[@]}")

                    # =================================================================
                    # Segunda peticion
                    # Particion boot '/boot'
                    # =================================================================
                    read -p "Utilizara particion para swap? (yes/no/y/n): " confirm
                    confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')
                    case "$confirm" in
                    yes | y)
                        echo "Realizando la acción..."
                        # ...
                        sleep 3
                        ;;
                    no | n)
                        echo "Acción cancelada."
                        sleep 2
                        break 2
                        ;;
                    *)
                        echo "Respuesta inválida. Por favor, responde yes o no (y/n)."
                        ;;
                    esac

                else

                    # Opcion no valida de la 2da peticion
                    echo "Respuesta inválida. Por favor intenta de nuevo."
                    sleep 2
                fi

            done

        else
            # Opcion no valida de 1ra peticion
            echo "Respuesta inválida. Por favor intenta de nuevo."
            sleep 2
        fi

    done

    # Confimacion de formateo
    clear
    echo "Las particion seleccionadas ${opciones[$root_part - 1]}, ${opciones[$boot_part - 1]} y ${opciones[$swap_part - 1]} seran formateadas."
    read -p "Desea continuar? (yes/no/y/n): " confirm
    confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

    case "$confirm" in
    yes | y)
        echo "Realizando la acción..."
        # ...
        sleep 3
        ;;
    no | n)
        echo "Acción cancelada."
        sleep 3
        ;;
    *)
        echo "Respuesta inválida. Por favor, responde sí o no."
        ;;
    esac
    sleep 5
done

echo $opcion
sleep 2
