#!/bin/bash

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

