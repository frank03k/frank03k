//: Playground - noun: a place where people can play

// Ziel dieser Lektion:
// If-Bedingung kennenlernen und anwenden
// Den Typ Bool verstehen

let bedingung = false

if bedingung {
    print ("Die Bedingung ist erfüllt")
} else {
    print("Die Bedingung ist nicht erfüllt.")
}


let zahl = 10

if zahl < 20 {
    print("Die Zahl ist kleiner als 20")
} else if zahl == 30 {
    print("Die Zahl ist gleich groß")
} else {
    print("Die Zahl ist weder kleiner als 20 noch 30")
}

if zahl < 100 {
    print("Die Zahl ist kleiner als 100")
} else if zahl < 50 {
    print("Die Zahl ist kleiner als 50")
}

// Challenge: Schreibt ein if-Statement, dass Strings überprüft und eine entsprechende Ausgabe enthält!

let string = "Hallo"

if string == "Guten Tag" {
    print("Der String lautet 'Guten Tag'")
} else if string == "Hallo" {
    print("Der String lautet 'Hallo'")
}
