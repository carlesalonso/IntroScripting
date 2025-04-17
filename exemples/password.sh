#!/bin/bash
# password.sh
# Assigna la contrasenya p@ssw0rd a tots els usuaris del sistema amb uidNumber >= 1000
# Autor: Marc López
# Data: 2023/10/03
# Versió: 1.0


if [[ $EUID -ne 0 ]]; then
  echo Has de ser root per executar aquest script
  exit 1
fi

#Obtenir usuaris amb uidNumber >= 1000
grep "x:[1-9][0-9][0-9][0-9]:" /etc/passwd | while read -r line
do
    usuari="$(cut -d ':' -f 1 <<< "$line")";
    echo "$usuari"
    echo -e "p@ssw0rd\np@ssw0rd" | (passwd  $usuari)
done
exit 0