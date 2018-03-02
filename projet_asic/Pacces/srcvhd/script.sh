#!/bin/bash

# source ../confmodelsim/config 

## nettoyage
if [ -d ../libs/LIB_PACCES ] 
then /bin/rm -rf ../libs/LIB_PACCES 
fi

## creation de la librairie de travail
vlib ../libs/LIB_PACCES

## compilation
vcom -work LIB_PACCES parking.vhd
