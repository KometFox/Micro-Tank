#Module import
from decimal import Decimal

"""
Constants/Types:
Cannon
Rocket
Autocannon
Artillery
Artillery_Rocket
Pistol
Submachinegun
Rifle
Machinegun

Material Modifiers:
Uranium, Plutonium, Abrudium, Tungsten, Wolfram

Regular Modifiers (Bonus/Upgrade):
Bonus1, Bonus2

Damage variables:
Radius
Piercing
Damage

Damage types:
Physical
Explosive




"""

#constants
damage_types = [
                "Physical",
                "Explosive",
                "Piercing",
                ]

modifiers = {
            "normal": 1.0,
            "uranium": 2.0,
            "plutonium": 1.5,
            "abrudium": 1.5,
            "tungsten": 1.5,
            "wolfram": 1.25
            }

constants_types = {
                "Cannon": 4.0,
                "Artillery": 8.0,
                "Rifle": 1.15,
                "Intermediate": 1.0,
                "SMG": 1.0,
                "Pistol": 1.0,
                }

constants_ammo ={
                "AP": 2.0,
                "HE": 1.5,
                "HEAT": 1.5,
                }

input = {
        50:
            {"Cannon": ["AP", "HE"], "Artillery": ["HE"]},
        }

test = damage_types, modifiers

def damage_calc(mm, a, const):
    #input variable
    cal = int(mm)
    base = int(a)
    constant = const
    
    #internal variable
    dmg = 0
    radius = 0
    pier = 0
    calc = 0
    calc2 = 0
    calc3 = 0
    type = ""
    
    #Calculations
    calc = cal * constant

    
    #print output
    print("caliber: {}mm  base-damage: {}".format(mm, calc))
    
    

def constants(dict1, dict2, dict3, dict4):
    i_print = ""
    calc = 0
    
    print("\n",dict1, "\n", dict2, "\n", dict3, "\n", dict4)

    for key1, value1 in dict1.items():
        pass
    
    for k, v in input.items():
        print("caliber: {}mm".format(k))
        
        for k2, v2 in v.items():
            print("k2:", k2, "v2:", v2)
            
            for v3 in v2:
                print("v3: ", v3)

#damage_calc(50,1,CANNON)
constants(constants_types, damage_types, modifiers, constants_ammo)
