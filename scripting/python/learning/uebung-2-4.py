#!/usr/bin/python
# coding: latin-1

import datetime

##################
# 1. Der Rauminhalt einer Kugel mit Radius r ist 4/3 pi r^3. Wie groß ist der Raum innerhalb einer Kugel mit dem Radius 5? 
##################
rauminhalt = (4/3)*3.14*(5**3)
print('Rauminhalt beträgt: '+ str(rauminhalt))

##################
# 2. Angenommen, der Verkaufspreis für ein Buch beträgt 24,95 Euro. Buchhändler erhalten einen Rabatt von 40 Prozent. Die Versandkosten betragen 3 Euro für das erste Buche und 75 Cent für jedes weitere Buch. Was ist der Händlergesamtpreis für 60 Bücher?
##################

buchpreis = 24.95
rabatt = 0.4
versand_erstes_buch = 3.0
versand_weiteres_buch = 0.75
anzahl_buecher = 60
restliche_buecher = anzahl_buecher - 1

# gesamt = einzelpreis inkl. rabatt * anzahl + 3 + 60 * 0,75
gesamtpreis = (buchpreis * rabatt * anzahl_buecher) + versand_erstes_buch + (versand_weiteres_buch * 60)
print('Der Gesamtpreis beträgt: ' + str(gesamtpreis))

##################
# 3. Wenn ich um 6:52 Uhr das Haus verlasse, einen Kilometer bei langsamem Tempo laufe (5:07 pro km) und drei Kilometer etwas schneller laufe (4:28 pro km), um wie viel Uhr komme ich dann zum Frühstück nach Hause?
##################

start_zeit = datetime.timedelta(hours = 6, minutes = 52)
langsam = datetime.timedelta(minutes = 5, seconds = 7)
schnell = datetime.timedelta(minutes = 4, seconds = 28)

# zielzeit = startzeit + 1 * 5:97 + 3 * 4:28
end_zeit = start_zeit + (1 * langsam) + (3 * schnell)
print('Ankunft zum Frühstück: ' + str(end_zeit) + ' Uhr.')