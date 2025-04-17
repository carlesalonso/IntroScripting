#!/bin/bash

# Crear usuari de forma desatesa
# format createUser usuari password

#Check if root
if [[ $EUID -ne 0 ]]; then
  echo Has de ser root per executar aquest script
  exit 1
fi

# Check number of parameters
if [[ $# -ne 2 ]]; then
    echo createUser usuari password
    exit 1
fi

# Test if user exists
id $1 &>/dev/null
if [[ $? -eq 0 ]]; then
    echo $1 ja existeix
    exit 1
fi

useradd -m -s /bin/bash $1 &>/dev/null
echo $1:$2 | chpasswd
id $1
exit 0