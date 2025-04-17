
#!/bin/bash

# floyd.sh
# Plots Floyd's triangle
# https://en.wikipedia.org/wiki/Floyd%27s_triangle
# Asks the user for the number of rows
# and prints the triangle with that number of rows
# The triangle is printed with asterisks
## Carlos Alonso
# 2019/01/08


clear
echo -n "Number of rows:"
read rows
# Check if rows is a number
# -eq operator works only with numbers

if ! test $rows -eq $rows  2> /dev/null
    then
        echo "Integers only"
        exit 1
fi

for ((i=1;i <= rows; i++))
    do
      for ((j=0; j < i; j++))
        do
            echo -n "*" 
         done
            echo
    done     
exit 0