//: Playground - noun: a place where people can play

// Ziel dieser Lektion:
// Den Typ Array kennenlernen und verwenden können
// Die Funktionsweise von Subscripts verstehen
// Arrays in Swift sind Sammlungen von mehreren Werten. Dabei kann nur ein Typ im Array enthalten sein, also zum Beispiel nur Strings oder nur Integers

let lieblingsEssen = ["Pizza", "Spaghetti", "Chips", "Döner"]

lieblingsEssen[0]

// Challenge: Probiert, den Wert Döner auszugeben

lieblingsEssen[3]

// Challenge: warum geht das mit unseren speziellen Array hier nicht?

var veränderbaresArray = [1, 2, 3, 4]

// Werte verändern

veränderbaresArray[1] = 10
veränderbaresArray

// Werte hinzufügen

veränderbaresArray.append(20)

// Werte entfernen

veränderbaresArray.remove(at: 2)

// Vorsicht:

// veränderbaresArray.remove(at: 7)

// Challenge: Verändert unser Array so, dass die Werte 1, 2, 20, 40 enthalten sind

veränderbaresArray[0] = 1
veränderbaresArray[1] = 2
veränderbaresArray[2] = 20
veränderbaresArray[3] = 40
veränderbaresArray
