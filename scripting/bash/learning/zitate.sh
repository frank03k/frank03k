#!/bin/bash
#Kursübung: Zufällige Zitate aus einem Array auslesen

r=$(( $RANDOM%10+0 ))

author="\t --Benjamin Franklin"

array=( "Wer die Freiheit aufgibt, um Sicherheit zu gewinnen, wird am Ende beides verlieren."
"Wer der Meinung ist, dass man für Geld alles haben kann, gerät leicht in den Verdacht, dass er für Geld alles zu tun bereit ist"
"Ein wahrhaft großer Mann wird weder einen Wurmzertreten noch vor dem Kaiser kriechen"
"Die ganz Schlauen sehen um fünf Ecken und sind geradeaus blind."
"Der unzufriedene Mensch findet keinen bequemen Stuhl."
"Nach Leiden und Verlusten werden die Menschenbescheidener und weiser"
"Eine Investition in Wissen bringt noch immer die besten Zinsen."
"Nichts in dieser Welt ist sicher, außer dem Tod und den Steuern."
"Bier ist der Beweis, dass Gott uns liebt und will, dass wir glücklich sind."
"Schreib Kränkungen in den Staub, Wohltaten in den Marmor!" )

echo
echo ${array[$r]}
echo -e "$author"
echo 
