#!/bin/bash
#Kursübung: Loale und Globale Variablen
speed=11

geschwindigkeit() {
local speed=10
echo 1: $speed
geschwind
}

geschwind() {
echo Geschwind: $speed
}
echo 2: $speed
geschwindigkeit
echo "---"
geschwind
echo 3: $speed
