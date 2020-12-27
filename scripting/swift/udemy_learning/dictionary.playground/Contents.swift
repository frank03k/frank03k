//: Playground - noun: a place where people can play

// Ziel dieser Lektion:
// Den Typ Dictionary kennenlernen und verwenden
// Die Bedeutung von Key-Value Paaren verstehen

let lieblingsEssen = ["Joey":"Pizza", "Lisa":"Schokolade", "Timmy":"Steak"]

// Challenge: Probiert doch einmal, den Wert Pizza auszugeben

lieblingsEssen["Joey"]

var veränderbaresDictionary = ["Zehn":10, "Drei":3, "Elf":11]

veränderbaresDictionary["Zehn"]

// Werte ändern

veränderbaresDictionary["Zehn"] = 100

// Werte hinzufügen

veränderbaresDictionary["Dreizehn"] = 13
veränderbaresDictionary

// Werte entfernen

veränderbaresDictionary.removeValue(forKey: "Zehn")
veränderbaresDictionary

veränderbaresDictionary.removeValue(forKey: "Joey")
