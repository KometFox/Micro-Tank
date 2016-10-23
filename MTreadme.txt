Mod Version: V1U Git Stable
#

OpenGL render is required!
Software doesn't support 3D models.
About the pk3:
Adds in tank classes about the size of a mice.
due to my limited knowledge, I cannot implent revolving turrets.

Author:
DOT

Supported Source Port: Zandronum 3.0, GZDoom
Supported IWAD: freedoom*.wad,doom*.wad
Modules: Enemies


Tools used:
Wings3D MLab, Blender, TimelineFX, GIMP, Krita, Slade 3 (XWE can go home)

Glossary: (not needed when you are familiar with military terms)
UGCV:    Unmanned Ground Combat Vehicle
AP:      Armor Piercing
APCRBC:  ^-Composite Rigid Ballistic Capped
APFSDS:  ^-Fin Stabilized Discarding Sabot
HE:      High Explosive
HEI:     ^-Incendiary
HECB:    ^-Cluster Bomb 
HEHM:    ^-Homing Missile
HEAT:    ^-Anti-Tank
FAE:     Fuel-Air Explosive
BioChem: Bio(logical)-Chemical
Inc:     Incendiary
RHA(e):  Rolled Homogeneous Armour (equivalency)	

 
	
of course the larger the caliber is, the more power it will have
but at the same time slower firing rate/reloading time

Important: You need to bind a key for cycling ammo when 
using the cannon. The same  goes for cycling the primary/secondary 
firing mode.

Short Ammo/Weapon info:  
Larger caliber are more powerful but takes longer to reload
all cannons.




Known bugs:
-Model looks a bit distorted/fucked up, I have no idea why.
fixed? I think a other MD3 plugin fixes this issuse

-Using (Alt)Firing are prone at jamming (not intentional).

-Savegames can get corrupted sometimes.
 

//note to self, dont forget to save textures via Gimp
//else Skulltag keeps moaning it can't find the texture
//atleast the shaderstyle Add removes properly
//the black background, unlike Spring RTS engine
//which can be partially visible if the CEG count is high

//2nd note: a sound name shouldn't be longer then 8 else it will not play


//3nd note: Spawn first definition must be always XXXX A 0
//XXXX = any sprite, failure to do so will cause unwanted
//effects 

//4th note: next time when making a model, don't forget to remove empty timelines
//else it will bloat up for no reason

//For Effects, anything with color or is "bright" needs black BG
// Smoke or "unbright" image should be transparent 
// hmm here it doesnt really matter much if the BG is transparent or black
// but black BG needs additive shading else black background is visible


Weapon Concept:

Example:
75mm/50mm Cannon
Fire:
Armor Piercing/"Instant-Hit" Shot, [Energy like?] or 
Frangible Frag Shot
Buckshot/Buckshot Explosive
High Explosive/White Phosphour
Hollow Charge/Ramjet Hollow Charge
Incendiary/Acid


,Explosive,??,Turbo,Acid
37mm Cannon
Fire:
Armor Piercing/Double AP [2x damage]
Buckshot/Buckshot Explosive
High Explosive/Unknown
Hollow Charge/Ramjet Hollow Charge
Flamethrower/Unknown
Laser beam/Plasma Ball

Any AltFire for Cannons:
Light/Heavy Russian MG, Grenade/Rocket Launcher, Laser Bolt Gun,Autocannon

Heavy Cannon (Medium/Heavy Tank only)
Fire:
Heavy Rocket (Incendiary/BioChem),Heavy AT Rocket (Seeking),??,??
Altfire:
??,??,??,??

Energy Cannon (Light Tank only)
Fire:
Laser Beam,Lightning Beam,Pulse Projectile
??,Thunder Strike,
Alfire:
??,??

Deep Ore Extractor
Fire:
Deployment then Extraction (2x Firing)
AltFire:
Cancel
=100% Done

2nd Resource "Weapon"
Water Extractor
Material Atomizer


UNKNOWN:
Missile/Rocket Launcher, Pulse Machine Gun, 2x20mm AutoCannon,
Quad Machine Gun. Nuclear Rocket Launcher.


Totally different weapon concept:
Instead of having several weapons or so it I would prefer something like this
A vehicle has 3 weapon slot:
1 HEAVY/SPECIAL
2 LIGHT
3 LIGHT (via upgrade maybe) 
4 Unknown/Grenade Pods?

All of those weapon should be almost be fired in simoulatenous manner,
when the 1 HEAVY got the Cannon weapon for example it should have all
functionalities it had previously, at least the FIRE part. Since the 2 other
light weapon slot can be used for fast firing ones instead.



(Special) Items:
AT-RocketLauncher 
Search Light (75% Done)
Scud Strike Marker (100% Done)
Shield Generator (0% Done)
Anthrax Sprayer (100% Done)
Flare-DONE
Illuminating-DONE
Smoke (75% Done)
  



Todo list:
-Decals (25% Done)
-More Dynamic Lights
-HUD needs some work
-More Upgrades
-Finish the upgrades for weapons (50% done)
-More Items (15% done)
-Organize the shit here better, its messy (20% done)
-100% Complete own Atlas texture either self made or with free resource.
Maybe a Hi-Res version should be available. but will it work in 4028x4028?
-A highly advanced particle system, decorate only (30% done)
-A highly advanced weapon system
-Better looking particles in general (sprites, style...) (15% done)
-Find a way to scale Particles in different manner instead of making
x amounts of copies.
-For weapons try to make Alt+Fire and Fire more flexible, 
-Better sound effects, give weapons etc a "OMPH" effect
-Add PzKpfW Tiger I (HT Skin), Add PzKpfw II Ausf L (LT Skin),
PzKpfw Panther/M10 (MT Skin)
-Add support for Oblige, with some few assets to go with or so

Enemies:
Neo-Bolsheviks (Neo-Bol): (5% done)
T-34, T-34-76, T-34-85, KV-1, KV-2, Infantries,Gun Placements,T-62
+Several upgrade version
American Corporation and Mercenary Coaliation (MerCorp): (5% done)
Light Mechs, Medium Mechs, Hover Tanks, 
Gangs:
Gun Trucks, Infantries, Gun Placement, 

Make Infantry,Vehicles,Aircraft etc... Have a new and a bit more advanced 
behavior (5% done)

NSA/Windows X is a piece of shit OS.

