#!/bin/bash

# Crear usuaris en format user1, user2...
# Com password es posa 123456
# Si l'usuari ja existeix s'elimina i es torna a Crear
# Carlos Alonso
# 03/12/2015
#

if [[ $EUID -ne 0 ]]; then
  echo "Has de ser root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "Cal indicar el nombre d'usuaris"
  exit 1
fi

password = '123456'

for (( i=1; i<= $1; i++))
do
  id user$i &> /dev/null
  if [ $? -eq 0 ]; then
    userdel -r user$i &> /dev/null
  fi
  useradd -m -s /bin/bash user$i &> /dev/null
  echo user$i:$password | chpasswd
done
exit 0