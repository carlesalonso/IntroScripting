# Guia per a la creació de scripts

## Introducció

Aquest document explica com crear scripts per gestionar sistemes Linux. Els scripts són una eina poderosa per automatitzar tasques repetitives i millorar l'eficiència en la gestió de sistemes.
Els scripts es poden escriure en diversos llenguatges, però aquí ens centrarem en `bash`, que és el shell per defecte en moltes distribucions de Linux.

## Estructura bàsica d'un script

Un script bàsic de bash comença amb una línia que indica quin intèrpret s'ha d'utilitzar per executar-lo. Aquesta línia es coneix com a "shebang". A continuació, és recomanable afegir comentaris per explicar el que fa l'script, autoria, data, etc.

```bash
#!/bin/bash
# Descripció: Aquest script fa X cosa
# Autor: El teu nom
# Data: DD/MM/YYYY
```

## Variables

Les variables s'assignen sense espais al voltant del signe igual. Per accedir a les variables, utilitza el símbol `$`. Les variables que definim nosaltres s'escriuen amb minúscula per convenció, mentre que les variables del sistema operatiu s'escriuen amb majúscula.

```bash
variable1="valor"
variable2=123
```

Per accedir a les variables, utilitza $variable1 o $variable2. Si vols mostrar el valor d'una variable, pots fer-ho així:

```bash

echo "El valor de variable1 és: $variable1"
echo "La ruta actual és: $PWD"
```

Es poden definir arrays:

```bash
array=(valor1 valor2 valor3)
echo "El primer element de l'array és: ${array[0]}"
```

Si s'utilitza com índex `@`, s'accedeix a tots els elements de l'array:

```bash
colors=("vermell" "verd" "blau")
echo "Colors disponibles: ${colors[@]}"
```

## Escrivint a la consola

Per escriure a la consola, utilitzem `echo` o `printf`. `echo` és més senzill, però `printf` ofereix més opcions de formatació.

```bash
echo "Hola, món!"
printf "Hola, món!\n" # \n afegeix un salt de línia
```

Per mostrar variables amb `printf`, utilitzem el format `%s` per cadenes de text i `%d` per números:

```bash
printf "El valor de variable1 és: %s\n" "$variable1"
printf "El valor de variable2 és: %d\n" "$variable2"
```

En el cas d'echo, si volem mostrar una variable amb un salt de línia, podem fer-ho així:

```bash
echo -e "El valor de variable1 és: $variable1\nEl valor de variable2 és: $variable2"
```

## Passant dades a l'script

Per passar dades a l'script, utilitzem arguments de línia de comanda. Els arguments es poden accedir mitjançant `$1`, `$2`, etc., on `$1` és el primer argument, `$2` és el segon, i així successivament. `$#` conté el nombre total d'arguments passats.

```bash
#!/bin/bash
# Script per sumar dos números passats com a arguments
resultat=$(( $1 + $2 ))
echo "La suma de $1 i $2 és: $resultat"
```

Més estrany és fer un script que hagi de ser interactiu i demanar dades a l'usuari. En aquest cas, utilitzem `read`:

```bash
#!/bin/bash
# Script per demanar un nom i saludar
echo "Introdueix el teu nom: "
read nom
echo "Hola, $nom!"
```

## Condicionals

```bash
if [ $variable2 -gt 100 ]; then
    echo "El valor és major que 100"
else
    echo "El valor és menor o igual que 100"
fi
```

En bash el `if` s'escriu amb el format `if [ condició ]; then`, on la condició pot ser qualsevol expressió que retorni un valor booleà. El `then` indica l'inici del bloc d'instruccions a executar si la condició és certa. El `else` és opcional i s'utilitza per definir el bloc d'instruccions a executar si la condició és falsa. Per finalitzar el bloc d'instruccions, s'utilitza `fi`.

En el cas de bash, zsh i altres shells moderns es recomana `[[ ]]` per fer comparacions més complexes, ja que permet usar expresions amb `&&`o `||`, expressions regulars i `pattern matching`. A continuació teniu un exemple:

```bash
if [[ $variable1 == "valor" && $variable2 -gt 100 ]]; then
    echo "Ambdós condicions són certes"
fi
```

Un condicional molt típic és comprovar si s'està executant com a root:

```bash
if [ "$(id -u)" -ne 0 ]; then
    echo "Aquest script ha de ser executat com a root"
    exit 1
fi
```

El `exit 1` força que l'script acabi i amb codi de sortida erroni.

Els condicionals també poden usar doble parèntesi `(( ))` per fer comparacions numèriques de forma similar a com fer-ho en llenguatges de programació com C o Java:

```bash
if (( variable2 > 100 )); then
    echo "El valor és major que 100"
else
    echo "El valor és menor o igual que 100"
fi
```

## Bucles

Els bucles són útils per repetir accions. Els més comuns són `for`, `while` i `until`.

### Exemples Bucle `for`

```bash
for i in {1..5}; do
    echo "Iteració $i"
done
```

Per iterar sobre un array:

```bash
array=(valor1 valor2 valor3)
for element in "${array[@]}"; do
    echo "Element: $element"
done
```

Per bucles sobre nombres s'usa el doble parèntesi per permetre usar el format típic de C:

```bash
for (( i=0; i<5; i++ )); do
    echo "Iteració $i"
done
```

### Exemple Bucle `while`

```bash
while [ $variable2 -lt 10 ]; do
    echo "Variable2 és menor que 10"
    ((variable2++)) # Incrementa variable2
done
```

### Exemple Bucle `until`

```bash
until [ $variable2 -ge 10 ]; do
    echo "Variable2 és menor que 10"
    ((variable2++)) # Incrementa variable2
done
```

## Funcions

Les funcions són blocs de codi reutilitzables. Es defineixen així:

```bash
function nom_funcio() {
    echo "Això és una funció"
}
```

Per cridar una funció, simplement escriu el seu nom:

```bash
nom_funcio
```

La funció pot acceptar arguments igual que un script. Per accedir als arguments dins de la funció, utilitza `$1`, `$2`, etc.

```bash
function suma() {
    resultat=$(( $1 + $2 ))
    echo "La suma de $1 i $2 és: $resultat"
}
suma 5 10 # Crida a la funció amb arguments 5 i 10
```

En bash una funció pot retornar un valor, però no de la mateixa manera que en altres llenguatges. En bash, el valor retornat és l'estat de la funció (0 per èxit, 1 per error). Si vols retornar un valor, pots utilitzar `echo` i capturar-lo quan crides la funció:

```bash
function suma() {
    resultat=$(( $1 + $2 ))
    echo "$resultat" # Retorna el resultat
}
resultat=$(suma 5 10) # Captura el valor retornat

## Codis de retorn

Els scripts poden retornar codis d'error. El codi 0 indica que tot ha anat bé, mentre que qualsevol altre codi indica un error. Per establir el codi de retorn, utilitza `exit`:

```bash
exit 0 # Tot ha anat bé
exit 1 # Hi ha hagut un error
```

## Comprovacions d'errors

Per comprovar si una comanda ha fallat, pots utilitzar `if` o `&&`:

```bash
comanda && echo "Comanda exitosa" || echo "Comanda fallida"
```

O bé usant la variables d'estat de la comanda anterior `$?`:

```bash
id "usuari" &>/dev/null
if [ $? -eq 0 ]; then
    echo "L'usuari existeix"
else
    echo "L'usuari no existeix"
fi
```

## Redirecció de sortida i errors

La redirecció de sortida i errors és útil per gestionar la sortida d'una comanda. Per redirigir la sortida estàndard a un fitxer, utilitza `>`:

```bash
comanda > fitxer.txt
```

Si el que volem és afegir la sortida a un fitxer existent, utilitzem `>>`:

```bash
comanda >> fitxer.txt
```

Per redirigir la sortida d'errors, utilitza `2>`:

```bash
comanda 2> error.txt
```

Per redirigir tant la sortida com els errors a un fitxer, utilitza `&>`:

```bash
comanda &> fitxer.txt
```

Un ús comú és redirigir tant la sortida estàndard com la d'errors a `/dev/null`, que és un "forat negre" on es descarten totes les dades:

```bash
comanda &>/dev/null
```

D'aquesta manera, no veuràs cap sortida ni error a la pantalla, de manera que a la pantalla únicament es mostrarà la sortida que gestioni l'script.

## Exemples senzills

### 1. Comprovar si un usuari existeix

```bash
if id "usuari" &>/dev/null; then
    echo "L'usuari existeix"
else
    echo "L'usuari no existeix"
fi
```

### 2. Crear directoris amb comprovació

```bash
DIRECTORI="/ruta/al/directori"
if [ ! -d "$DIRECTORI" ]; then
    mkdir -p "$DIRECTORI"
    echo "Directori creat correctament"
fi
```

### 3. Comprovar si el número d'arguments és correcte

```bash
if [ $# -ne 2 ]; then
    echo "Ús: $0 argument1 argument2"
    exit 1
fi
```

A la carpeta `exemples` trobaràs exemples d'scripts senzills que et poden ser útils:

- [countdown.sh](exemples/countdown.sh) - Script per fer un compte enrere passant el temps com argument
- [floyd.sh](exemples/floyd.sh) - Script per dibuixar un triangle de Floyd
- [password.sh](exemples/password.sh) - Script per canviar la contrasenya a tots els usuari
- [create_user.sh](exemples/create_user.sh) - Script per crear un usuari amb nom i password passats com arguments
- [create_users.sh](exemples/create_users.sh) - Script per crear diversos usuaris amb un nom base i un número de seqüència

## Execució d'scripts

Per executar un script, primer cal donar-li permisos d'execució. Això es fa amb la comanda `chmod`:

```bash
chmod +x nom_script.sh
```

Després, pots executar l'script amb:

```bash
./nom_script.sh
```

El script també es pot executar amb `bash nom_script.sh`en aquest cas, no cal donar permisos d'execució.

## Bones pràctiques

- Sempre comenta el codi
- Utilitza noms descriptius per variables
- Comprova errors després d'operacions importants
- Fes servir `set -e` per aturar el script si hi ha errors

## Recursos Addicionals

- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/index.html) - Guia avançada de scripting en bash
- [Bash Hackers Wiki](http://wiki.bash-hackers.org/start) - Wiki amb informació avançada sobre bash
- `man bash` per documentació completa
- [Shellcheck](https://www.shellcheck.net) eina online per validar scripts
- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)
