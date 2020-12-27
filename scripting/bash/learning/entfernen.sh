#!/bin/bash
#Kursübung: Malware entfernen aus über 100 HTML Dateien mittels Bash Scripting
#

read -p "Ordner der Durchsucht werden soll: " folder
read -p "Beginnenden Suchtag " tag1
read -p "Endenden Suchtag " tag2

echo "Vearbeitung beginnt...."
find $folder -type f -print0 | xargs -0 sed -i -e "s/$tag1.*$tag2//g"
echo "Skript beendet"
