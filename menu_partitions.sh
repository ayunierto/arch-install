#!/bin/bash

source format_partitions.sh

load_partitions() {
    # Obtener las particiones
    string=$(echo $(lsblk | grep 'part' | sed 's/├─//g' | sed 's/└─//g' | awk '{print $1}'))
    # Convertir la lista de particiones en un array
    IFS=' ' read -r -a options <<<"$string"
    options+=("Volver al menu principal")
}

list_partitions() {
    clear
    echo "============================="
    echo " Seleccione las particiones"
    echo "============================="
    echo
    lsblk
    echo

    # Mostrar lista de particiones
    for i in "${!options[@]}"; do
        echo "$((i + 1)). ${options[$i]}"
    done
    echo "============================="
    echo
}

menu_partitions() {

    load_partitions

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
                break 2
            fi

            # Decrementando en 1 para que coincida con el indice del arreglo
	    	# ya que el indice comienza con 0
            root_part=$((root_part - 1))

            # Elminar la particion seleccionada del array de opciones
            new_array=()
            for ((i = 0; i < ${#options[@]}; i++)); do
                if [ $i -ne $root_part ]; then
                    new_array+=("${options[$i]}")
                fi
            done
			
            # Seleccionar el nombre de la particion
			root_part=(${options[$root_part]})

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
					
                    # Seleccionar el nombre de la particion
					boot_part=(${options[$boot_part]})

                    # Reemplazar el array original con el nuevo
                    options=("${new_array[@]}")

                    # =================================================================
                    # Tercera peticion
                    # Particion swap
                    # =================================================================
					while true; do

                        read -p "Desea utilizar particion para swap? (yes/no/y/n): " confirm

		                # Transdormamos las respuestas en minusculas
                        confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

                        case "$confirm" in
                            yes | y)
                                list_partitions
                                read -p "Selecciona la particion para swap 'swap' [1-${#options[@]}]: " swap_part

                                # Validar la opción ingresada
                                if [[ $swap_part -ge 1 && $swap_part -le ${#options[@]} ]]; then
                                    if [[ $swap_part -eq ${#options[@]} ]]; then
                                    break 4
                                    fi
                
                                    # Decrementando en 1 para que coincida con el indice del arreglo
                                    swap_part=$((swap_part - 1))

                                    # Elminar la particion seleccionada del array de opciones
                                    new_array=()
                                
                                    for ((i = 0; i < ${#options[@]}; i++)); do
                                        if [ $i -ne $swap_part ]; then
                                        new_array+=("${options[$i]}")
                                        fi
                                    done
                                    
                                    swap_part=(${options[$swap_part]})

                                    # Reemplazar el array original con el nuevo
                                    options=("${new_array[@]}")

                                    format_partitions $root_part $boot_part $swap_part
                                    read esperar

                                else
                                # Opcion no valida de la 3ra peticion
                                echo "Respuesta inválida. Por favor intenta de nuevo."
                                sleep 2
                                fi
                                ;;
                            no | n)
                                echo
                                format_partitions $root_part $boot_part
                                sleep 4
                                read esperar
                                ;;
                            *)
                                echo "Respuesta inválida. Por favor responde (yes/no/y/n)."
                                sleep 2
                                ;;
                        esac
				    done 

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
}
