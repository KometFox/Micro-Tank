# Name: Caliber damage calculator
# Use for: For figuring out how much more "damage" a certain ammo type would do and 
# mainly to keep consistency. For now it should only deal with simple damage values so nothing with realism stuff yet
#
"""
TODO:
 -Add user inputs
 -Options to save output to a text file and eventually reading it too
 -Options for "profiles" when dealing with different calculation values
 -Method for determining cluster or area of effect munitions
 -Method for determining range
 -Improve HE shell calculation
 -Method for APHE shell calculation
 -Method for determining barrel length (only affects for Kinetic Energy based munition)
 -No hardcoded constants
 
Properties:
AP -
High Damage on impact
Minor (if any) radius damage 
losses power over range
HE -
Low-Medium damage on impact
Medium radius damage
HEAT -
High damage on impact
Minor-ish radius damage


Material enhance:
Uranium, Plutonium, Abrudium, Tungsten, Thermite, Napalm, 

"""
from decimal import Decimal


#------
#Constants
#------
CONTEXT = "Factorio modding."
S_DMG = "Damage:"
S_RAD = "Radius:"
S_PEN = "Penetration:"
S_AP = "Armor Piercing"
S_HE = "High Explosive"
S_URAN = "Uran"
S_ABRUD = "Abrudium"
S_PHY = "Physical"
S_EXPL = "Explosion"
S_SHELL = "Shell"
S_SHOT = "Shot"

#Damage
ARTILLERY = 8.0
CANNON = 4 #1.56
RIFLE = 1.15
INTERMEDIATE = 1.0
SMG = 1.0
PISTOL = 1.0

#Range
#RPM
#Reloading
#Types
HE_RADIUS = 50
AP_PEN = 1.5 
BONUS = 1.3  #5.5 #1.3 #%
BONUS2 = 1.6  #11 #1.6 #%

AP = 1.45 #1.45
HE = 1.25 

#------
#Caliber lists in mm
#------
D_Cannon = {
        50: ["AP", "HE"],
#        60: ["AP", "HE"],
#        75: ["AP", "HE"],
#        88: ["AP", "HE"],
#        100: ["AP", "HE"],
         25: ["AP","AP2", "AP3", "HE", "HE2"],
#        120: ["AP", "HE"],
#        130: ["AP", "HE"],
         }

D_Missile = {
        "50": ["HE"],
          }


print("Context:", CONTEXT, "\n")

for keys, values in D_Cannon.items():
    calc = keys * CANNON
    calc = round(calc, 2)
    print("{}mm: base damage -".format(keys), calc)

    for v2 in values:
        if "AP" == v2:
            print(v2, "damage:", round(calc * AP, 2), "penetration:", round(calc * AP_PEN))
        if "AP2" == v2:
            print(v2, "damage:", round((calc * AP) * BONUS, 2), "penetration:", round((calc * AP_PEN) * BONUS, 2))
        if "AP3" == v2:
            print(v2, "damage:", round((calc * AP) * BONUS2, 2), "penetration:", round((calc * AP_PEN) * BONUS2, 2))
        if "HE" == v2:
            print(v2, "damage:", calc * HE, "radius:", round(calc / HE_RADIUS, 2))
        if "HE2" == v2:
            print(v2, "damage:", (calc * HE) * BONUS, "radius:", round((calc / HE_RADIUS) * BONUS / 1.12, 2))            
    print("#----------#")
