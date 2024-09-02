source system_config.sh

format_partitions() {
	while true; do
		clear

		echo
		echo -e "\e[33mADVERTENCIA !!!\e[0m"
		echo "Las siguientes particiones se formatearan."
		echo
		echo "Particion $1 como '/'"
		echo "Particion $2 como '/boot'"
		if [ -n "$3" ]; then
			echo "Particion $3 para intercambio"
		fi
		echo
		
		lsblk | grep 'part' | sed 's/├─//g' | sed 's/└─//g' 
		
		echo -e -n "\e[31mEsta seguro que desea realizar esta operacion? (yes/no/y/n): \e[0m"
	    read confirm	
		
		# Transdormamos las respuestas en minusculas
    	confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

    	case "$confirm" in
       	 	yes | y)
				echo "Formateando particiones..."
				echo "Tiene 5 segundos para cancelar la operacion de ser necesario"
				sleep 5

				mkfs.ext4 /dev/$1
				if [ -n "$3" ]; then
					mkswap /dev/$3
				fi
				mkfs.fat -F 32 /dev/$2

				mount /dev/$1 /mnt
				mount --mkdir /dev/$2 /mnt/boot
				if [ -n "$3" ]; then
					swapon /dev/$3
				fi

				pacstrap -K /mnt base linux linux-firmware base-devel

				# Configuración del sistema
				system_config

				;;
        	no | n)
				echo "Operacion cancelada."
				echo "Saliendo..."
				sleep 2
				exit
                ;;
        	*)
                echo "Respuesta inválida. Por favor responde (yes/no/y/n)."
		    	sleep 2
               	;;
        esac
    done

}
