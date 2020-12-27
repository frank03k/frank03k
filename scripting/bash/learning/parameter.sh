#!/bin/bash
#Kursübung: Parameter übergabe mit while, case und getopts

# /parameter.sh -b -r -w

#while [ "$1" != '' ]
# do
#	[ "$1" == "-b" ] && echo "Backup wird gestartet" && BACKUP="aktiv" && shift
#	[ "$1" == "-w" ] && echo "Backup wiederherstellung gestartet" && WIEDERHERSTELLUNG="aktiv" && shift
#	[ "$1" = "-r" ] && echo "Reiningung der Backups gestartet" && REINING="aktiv" && shift
#done

#####GET OPTIONTEST

while getopts ':bwro:' OPTION ; 
do

case "$OPTION" in
b) echo "Backup starten"
BACKUP="aktiv";;
w) echo "Wiederherstellung starten";;
r) echo "Reinigung starten";;
o) echo "Backup Ordner ist in: $OPTARG";;
esac
done
