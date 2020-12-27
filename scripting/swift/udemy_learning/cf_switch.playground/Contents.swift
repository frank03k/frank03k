//: Playground - noun: a place where people can play

// Ziel dieser Lektion:
// Switch Bedingung verstehen

let zahl = 10

switch zahl {
case 10:
    print("Die Zahl ist 10.")
case 20:
    print("Die Zahl ist 20.")
default:
    print("Die Zahl ist unbekannt.")
}

// Bereichsoperator

0...30

0..<30

let andereZahl = 20

switch andereZahl {
case 20:
    print("Die Zahl ist 20.")
    fallthrough // --> weitere Cases werden überprüft bis wieder die Bedingung erfüllt ist
case 0...30:
    print("Die Zahl ist zwischen 0 und 30")
default:
    break
}
