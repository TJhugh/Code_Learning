# -*- coding: utf-8 -*-
"""
Created on Fri Jun 10 13:43:00 2016

@author: z030757
"""

names = ["Alice", "Bob", "Casie", "Diane", "Ellen"]


for name in names:
    print(name)
 
   
for word in names:
    print("Hello ", word)


names[0]    #First entry in list "names"


for name in names:
    if name[0] in "AEIOU":
        print(name, " starts with a vowel")

        
vowel_names = []

for name in names:
    if name[0] in "AEIOU":
        vowel_names.append(name)


prices = [1.5, 2.35, 5.99, 16.49]

total = 0
for item in prices:
    total += item

        
sum(prices)

ice_cream = {"Alice": "chocolate", "Bob": "strawberry", "Cara": "mint chocolate chip"}

ice_cream["Alice"]

ice_cream["Eve"] = "rum raisin"



import random
random.randint(1, 6)
cards = ["jack", "queen", "king", "ace"]
random.choice(cards)
help(random)

counter = 0
while counter < 5:
    print("Hello ", str(counter))
    counter += 1
    

