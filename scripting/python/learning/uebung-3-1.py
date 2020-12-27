#!/usr/bin/python
# coding: latin-1

# Original
#def zeige_text ():
#    print("Veronika, der Lenz ist da.")
#    print("Die Mädchen singen trallala.")
#
#def wiederhole_refrain():
#    zeige_text()
#    zeige_text()
#
#wiederhole_refrain()

# Aufgabe:
# Verschieben Sie die letzte Zeile dieses Programms ganz nach oben, sodass der Funktionsaufruf vor den Definitionen erfolgt. Starten Sie das Programm, und schauen Sie, welche Fehlermeldung Sie erhalten.

def wiederhole_refrain():
    zeige_text()
    zeige_text()

def zeige_text ():
    print("Veronika, der Lenz ist da.")
    print("Die Mädchen singen trallala.")

wiederhole_refrain()
