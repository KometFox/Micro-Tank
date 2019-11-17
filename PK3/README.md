Mod Version: 1V Git Development
#

OpenGL render is required!
Software doesn't support 3D models.
About the pk3:
Adds in tank classes about the size of a mice.

Author:
DOT

Supported Source Port: Zandronum 3.0-3.1, GZDoom 1.8.6, GZDoom 4.2.0
Supported IWAD: freedoom*.wad, doom*.wad
Modules: Enemies, Missionpack 1


Classes:

<Heavy Tank>
The most armored and heaviest tank type available, it boast a supreme firepower
which can destroy almost any target with ease. However it's great firepower comes
at a cost with slower driving, turning speed and reloading time. Nonetheless
it is a Coloss that should not be underestimated with the power it can provide.

<Medium Tank>
It is a balance between firepower, mobility and protection. This tank type
offers a well all-rounder capacity that is good enough for fast assault attacks
and withstanding incoming shells.

<Light Tank>
The fastest and most fragile tank class available, its nimble agility allows 
for a efficient hit and run tactics however it suffers from a very poor firepower
and wouldn't be able to withstand heavy tanks easily. 

<Medium Assault Gun>
A fixed casemate styled tank, it sacrifices its ability for a 360° attack in 
exchange for even more firepower and protection, such properties makes it less 
capable to respond against attacks from unexcepted angle. However in turn when
this tank takes advance of its lower silohette and tactical position it can wreck
havoc among unexcepted force.

<Heavy Assault Gun>
Tools used:
Blender, Slade3

Glossary: 
UGCV:    Unmanned Ground Combat Vehicle
AP:      Armor Piercing
APCR:    ^-Composite Rigid
APCRBC:  ^-Composite Rigid Ballistic Capped
APFSDS:  ^-Fin Stabilized Discarding Sabot
HE:      High Explosive
HEI:     ^-Incendiary
HECB:    ^-Cluster Bomb 
HEHM:    ^-Homing Missile
HEAT:    ^-Anti-Tank
FAE:     Fuel-Air Explosive
BioChem: Bio(logical)-Chemical
Chem:    Chemical
Inc:     Incendiary
Nap:     Napalm
RHA(e):  Rolled Homogeneous Armour (equivalency)	


TODO:
Heavy and Medium Assault Guns
Medium and Light Hovertank
Goliath Tank
MBT Tank

	
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

