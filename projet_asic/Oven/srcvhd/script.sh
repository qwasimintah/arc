#!/bin/bash

# source ../confmodelsim/config 

## nettoyage
if [ -d ../libs/LIB_OVEN ] 
then /bin/rm -rf ../libs/LIB_OVEN 
fi

## creation de la librairie de travail
vlib ../libs/LIB_OVEN

## compilation
#vcom -work LIB_OVEN oven_bin.vhd -cover bsf
#vcom -work LIB_OVEN oven.vhd -cover bsf
#vcom -work LIB_OVEN counter.vhdl -cover bsf 
#vcom -work LIB_OVEN oven_glob.vhd -cover bsf
vcom -work LIB_OVEN oven_bin.vhd
vcom -work LIB_OVEN oven_gray.vhd
vcom -work LIB_OVEN oven_oneh.vhd
vcom -work LIB_OVEN oven.vhd 
vcom -work LIB_OVEN counter.vhdl
vcom -work LIB_OVEN oven_glob.vhd 
