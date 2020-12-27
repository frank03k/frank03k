#!/bin/bash
#Kursübung: Passwort einlesen und nicht anzeigen bei der Eingabe
read -p "Bitte den Benutzer angeben: " benutzer

stty -echo
read -p "Bitte das Passwort angeben: " passwort
stty echo

echo ""
echo "---"
echo "Der $benutzer ist angemeldet mit dem Passwort: $passwort"

