#!/bin/bash
#Kursübung: case anweisung

tag=$(date +%a)

case "$tag" in
Mo|Mon|Wed|Mit|Fr|Fri)		echo "Das ist das Backup für Server1";;
Do|Thu|Die|Tue)			echo "Das ist das Backup für Server2";;
*)			echo "Ein volles Backup für die ganze Woche";;
esac


case $1 in
[Jj]|[Jj][aA]) echo "Die Befehle werden ausgeführt";;
[nN]|[Nn][eE][iI][Nn]) echo "Die Befehle werden NICHT ausgeführt";;
*) echo "Es wurde kein Befehl übergeben wählen Sie Ja oder Nein";;
esac

case $2 in
-[hH]|-help|hilfe)	echo "Hier wird die Hilfe aufgerufen";;
*)			echo "Hier wird eine fremde Option benutzt";;
esac
