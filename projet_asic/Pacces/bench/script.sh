#!/bin/bash

## nettoyage
if [ -d ../libs/LIB_PACCES_BENCH ] 
then /bin/rm -rf ../libs/LIB_PACCES_BENCH
fi

## creation de la librairie de travail
vlib ../libs/LIB_PACCES_BENCH


## compilation
vcom -work LIB_PACCES_BENCH test2Pacces.vhd

