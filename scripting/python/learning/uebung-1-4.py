#!/usr/bin/python
# coding: latin-1

# Wenn Sie 10 Kilometer in 43 Minuten und 30 Sekunden laufen, wie ist dann Ihre Durchschnittszeit pro Kilometer? Wie hoch ist Ihre Geschwindigkeit in Meilen pro Stunde? (Tipp: Eine Meile entspricht 1,61 Kilometer)

# Rechne Kilometer in Meilen um
kilometer = 10
meile = 1.61
gesamt_meilen = kilometer/meile

# Berechne Durchschnittszeit
zeit_in_minuten = 43.5
durchschnittszeit = zeit_in_minuten/kilometer
print('Die Durchschnittszeit beträgt: ' + str(durchschnittszeit) + ' Minuten pro Kilometer.')

# Berechne Meilen pro Stunde
zeit_in_stunden = zeit_in_minuten/60
meilen_pro_stunde = gesamt_meilen/zeit_in_stunden
print('Die Geschwindigkeit beträgt: ' + str(meilen_pro_stunde) + ' meilen/h.')
