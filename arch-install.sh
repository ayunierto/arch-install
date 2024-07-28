#!/bin/bash
#
# Script para instalacion del sistema operativo Arch.
# Creado por aytodev
#

opc=0

while [[ $opc -ne 4 ]]; do
  clear
  echo "Bienvenido al instalador de Arch (creado por aytodev)"
  echo ""
  echo "1. Particionado de discos. (cfdisk)"
  echo "2. Elegir particiones e instalar."
  echo "3. Salir"
  echo ""
  read -p "Selecciona una opcion: " opc

  case "$opc" in
    1)  
      sudo cfdisk
      clear
      echo "Saliendo del particionador..."
      sleep 3
    ;;
    2)
      clear
      while true; do
        echo "====================="
        echo " Menú de opciones"
        echo "====================="
        echo "1. Opción 1"
        echo "2. Opción 2"
        echo "3. Opción 3"
        echo "4. Salir"
        echo "====================="
        read -p "Selecciona una opción [1-4]: " opcion

        case $opcion in
            1) opcion1 ;;
            2) opcion2 ;;
            3) opcion3 ;;
            4) echo "Saliendo del programa..."; break ;;
            *) echo "Opción no válida. Por favor intenta de nuevo." ;;
        esac
    done
    ;;
    3)clear 
      echo "Saliendo del programa de instalacion"
      sleep 3
    ;;
    *) echo "$opc no es una opcion valida"
      sleep 3
      break 
    ;;
  esac
  
done