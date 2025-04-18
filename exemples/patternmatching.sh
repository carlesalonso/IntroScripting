#!/bin/bash

## Exemples de comparacions usant pattern matching
## Carlos Alonso
## 2025/04/18

## Pattern matching
## El pattern matching o coindicència de patrons, és una eina molt potent 
## per a la manipulació de cadenes de text.

## Els casos més senzill són els comodins

## El comodí * coincideix amb qualsevol cadena de text, incloent la cadena buida
## El comodí ? coincideix amb un sol caràcter

## Comparacions usant comodins bàsics

cadena="abc123"

## Comprova si la cadena comença per a
if [[ $cadena == a* ]]; then
    echo "La cadena comença per a"
else
    echo "La cadena no comença per a"
fi
read -p "Pulsa una tecla per seguir... "

## Comprova si la cadena tingui el format a dos caracters i acabi amb 123
if [[ $cadena == a??123 ]]; then
    echo "La cadena té el format a dos caracters i acaba amb 123"
else
    echo "La cadena no té el format a dos caracters i acaba amb 123"
fi
read -p "Pulsa una tecla per seguir... "

## Pattern matching avançat
## [abc] coincideix amb un sol caràcter que sigui a, b o c
## [a-z] coincideix amb un sol caràcter que sigui una lletra minúscula

## Comprova si el segon caràcter és una lletra minúscula
if [[ $cadena == ?[a-z]* ]]; then
    echo "El segon caràcter és una lletra minúscula"
else
    echo "El segon caràcter no és una lletra minúscula"
fi
read -p "Pulsa una tecla per seguir... "

## Comprova si el tercer caràcter és una c o una d
if [[ $cadena == ??[cd]* ]]; then
    echo "El tercer caràcter és una c o una d"
else
    echo "El tercer caràcter no és una c o una d"
fi

## Comprova si la cadena té el valor de something o anything
## El símbol + indica que el patró anterior pot aparèixer una o més vegades
## El símbol * indica que el patró anterior pot aparèixer zero o més vegades
## El símbol ? indica que el patró anterior pot aparèixer zero o una vegada
## Els símbol @ indica exactament una coincidència
## El símbol | indica que el patró anterior pot ser un o altre
## El símbol () indica que el patró anterior és un grup

cadena="something"
if [[ $cadena == @(some|any)thing ]]; then
    echo "La cadena és something o anything"
else
    echo "La cadena no és something ni anything"
fi
read -p "Pulsa una tecla per seguir... "



