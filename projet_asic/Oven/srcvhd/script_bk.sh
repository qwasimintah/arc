#!/bin/bash

# source ../confmodelsim/config 

## nettoyage
if [ -d ../libs/LIB_OVEN ] 
then /bin/rm -rf ../libs/LIB_OVEN 
fi

## creation de la librairie de travail
vlib ../libs/LIB_OVEN

## compilation
vcom -work LIB_OVEN oven.vhd 
vcom -work LIB_OVEN counter.vhdl 
vcom -work LIB_OVEN oven_glob.vhd 
