//: Playground - noun: a place where people can play

// Ziel dieser Lektion:
// For Schleifen kennenlernen und anwenden

for _ in 0...4 {
    print("Test")
}

for zähler in 0...4 {
    print(zähler)
}

for zähler in stride(from: 2, to: 100, by: 20) {
    print(zähler)
}

for zähler in stride(from: 0, through: 100, by: 20) {
    print(zähler)
}

let array = [1,2,3,4,5,10,20,30,40,50]

for eintrag in array {
    print(eintrag)
}

for (index,eintrag) in array.enumerated() {
    print("Der Index \(index) hat den Wert \(eintrag)")
}

let dictionary = ["Joey":26, "Tim":25, "Lisa":21]

for (name,alter) in dictionary {
    print("\(name) ist \(alter) Jahre alt.")
}


