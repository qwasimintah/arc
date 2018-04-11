#!/bin/bash

## nettoyage
if [ -d ../libs/LIB_OVEN_BENCH ] 
then /bin/rm -rf ../libs/LIB_OVEN_BENCH
fi

## creation de la librairie de travail
vlib ../libs/LIB_OVEN_BENCH


## compilation
vcom -work LIB_OVEN_BENCH testOven.vhd -cover bsf

