//: Playgroun - noun: a place where people can play

// Ziel dieser Lektion:
// Logische Operatoren kennenlernen und anwenden

// && ist das logische UND
1 == 1 && 2 == 2
1 == 1 && 2 == 3

// || ist das logische ODER
1 == 1 || 2 == 3

// ! ist das logische NICHT
!true
!false

let code = true
let schlüssel = true
let fingerabdruck = false

if code && schlüssel || fingerabdruck {
    print("Zugang gewährt")
} else {
    print("Zugang verweigert")
}
