import random

# Auflistung vom Mittagsoptionen
mittag = ["Pho Viet", "Soup & Nem", "Mutti", "Peter Pan", "Rockeria", "Crustys", "Indian Palace", "Valentino", "maredo", "Tamers", "Augustiner", "Ratskeller", "Johann S."]

r = random.randint(0, len(mittag) - 1 )

print("Heute geht es zum Mittagessen zu " + mittag[r] +"!")