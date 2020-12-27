#!/bin/bash
#Kursübun: while-Schleife

a=0
while [ $a -lt $1 ]
do
sleep 1
zahl=$(rand)
echo "$a : $zahl"
a=$(( $a + 3 ))
done
