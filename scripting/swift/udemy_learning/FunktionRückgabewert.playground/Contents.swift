//: Playground - noun: a place where people can play

// Ziel dieser Lektion:
// Rückgabewert von Funktionen kennenlernen und anwenden

func multipliziere(_ zahl: Int, und andereZahl: Int) -> Int {
    return zahl * andereZahl
}

let produkt = multipliziere(10, und: 30)
print("Das Produkt ist \(produkt)")

let zahl = 5
let andereZahl = 40

print("Das Produkt von \(zahl) und \(andereZahl) ist \(multipliziere(zahl, und: andereZahl))")

func addiereUndSubtrahiere(_ zahl: Int, und andereZahl: Int) -> (summe: Int, differenz: Int) {
    return (zahl + andereZahl, zahl - andereZahl)
}

let ergebnis = addiereUndSubtrahiere(5, und: 3)

print("Die Summer ist \(ergebnis.summe) und die Differenz ist \(ergebnis.differenz)")

