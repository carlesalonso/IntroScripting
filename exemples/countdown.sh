#!/bin/bash

# Countdown.sh
# A countdown using decremental for
#
# Carlos Alonso
# 01-12-2015

# Check if the user has provided a number
if [ $# -eq 0 ]; then
  echo "Usage: $0 <number>"
  exit 1
fi
# Check if the argument is a positive integer
if [ $1 -lt 0 ]; then
  echo "Error: Argument must be a positive integer"
  exit 1
fi
for (( i=count;i>=0;i-- ))
do
  echo -ne "$i  \r"
  sleep 1
done
echo "Boom!!!!"
exit 0