#!/bin/bash
#Kursübung
#Automatische & Vordefinierte Variablen

# $0  , dann wird uns das Scriptname angezeigt
# $1 - höher angeben dann werden uns die zusatz kommandos angezeigt
# $* Alle zusatzkommandos in einer Zeichenkette anzuzeigen.
# $@  in ein Array gelegt
# $_  dies führt den letzten befehl nochmal aus
# $# Zeigt an wieviele Befehle übergeben worden sind
# $$ Zeigt uns die Prozessnummer an
# $? Abfrage der Bedingung ob der letzte Befehl in Ordnung war
# $! ProzessID des letzte Befehls an

echo "Diese Script hat die Prozessnummer: $$"

echo "Die aktuelle Sprache ist: $LANGUAGE"

echo "In Ordnung: $?"

echo "Mein zusatzkommando ist $1 $2 $3 $4 ($!)"

echo "Raute: $# ($!)"

echo "Last Befehl: $_"

echo "Alle kommandos: $* ($!)"
