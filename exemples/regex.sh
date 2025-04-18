#!/bin/bash

## Exemples de comparacions usant expressions regulars
## Carlos Alonso
## 2025/04/18

## Expressions regulars
## Les expressions regulars són una eina molt potent per a la manipulació de cadenes de text
## https://ioflood.com/blog/bash-regex/

### Per usar expressions regulars s'ha d'usar el doble corxet i el símbol =~
### El símbol =~ indica que la cadena de la dreta és una expressió regular

cadena="abc123"

## Comprova si la cadena conté un número
if [[ $cadena =~ [0-9] ]]; then
    echo "La cadena conté un número"
else
    echo "La cadena no conté un número"
fi
read -p "Pulsa una tecla per seguir... "

## Comprova si la cadena conté un número i una lletra
if [[ $cadena =~ [0-9] && $cadena =~ [a-zA-Z] ]]; then
    echo "La cadena conté un número i una lletra"
else
    echo "La cadena no conté un número i una lletra"
fi
read -p "Pulsa una tecla per seguir... "

## Comprova si la cadena conté un número i una lletra en majúscula
if [[ $cadena =~ [0-9] && $cadena =~ [A-Z] ]]; then
    echo "La cadena conté un número i una lletra en majúscula"
else
    echo "La cadena no conté un número i una lletra en majúscula"
fi
read -p "Pulsa una tecla per seguir... "

## Comprova si la cadena comença amb una lletra
if [[ $cadena =~ ^[a-zA-Z] ]]; then
    echo "La cadena comença amb una lletra"
else
    echo "La cadena no comença amb una lletra"
fi
read -p "Pulsa una tecla per seguir... "

## Comprova si la cadena comença amb una lletra seguida d'un número
if [[ $cadena =~ ^[a-zA-Z][0-9] ]]; then
    echo "La cadena comença amb una lletra seguida d'un número"
else
    echo "La cadena no comença amb una lletra seguida d'un número"
fi
read -p "Pulsa una tecla per seguir... "

## Comprova si la cadena és un DNI. No comprova si el DNI és vàlid, però sí que comprova el format
## El format és 8 números seguits d'una lletra

if [[ $cadena =~ ^[0-9]{8}[A-Z]$ ]]; then
    echo "La cadena és un DNI"
else
    echo "La cadena no és un DNI"
fi
read -p "Pulsa una tecla per acabar"
exit 0
