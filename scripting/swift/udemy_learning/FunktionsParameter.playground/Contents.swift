//: Playground - noun: a place where people can play

// Ziel dieser Lektion:
// Funktionsparameter kennenlernen und anwenden

func multipliziere(zahl: Double, andereZahl: Double) {
    print(zahl * andereZahl)
}

multipliziere(zahl: 2.0, andereZahl: 20.0)


// _ --> für externen Variablen aufruf
// zahl --> innerhalb der Funkltion
func multipliziereNew(_ zahl: Int, und andereZahl: Int) {
    print(zahl * andereZahl)
}

multipliziereNew(10, und: 20)

func nennNamen(_ vorname: String, und nachname: String) {
    print("Hallo " + vorname + " " + nachname)
}

nennNamen("Frank", und: "Kupsch")
