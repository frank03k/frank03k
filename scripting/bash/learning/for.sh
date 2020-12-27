#!/bin/bash
#Kursübung:for-Schleife

for datei in "$@"
do
[ -f $datei ] && echo Die Datei heisst: $datei && cp $datei $datei".copy" && echo $datei".copy wurde angelegt"
done



for abc in "Hallo" "Welt" "Universum" "Planet"
do
	echo $abc
done


for ((i=3;i<=30;i+=3))
do
echo $i
done
