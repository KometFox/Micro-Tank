Class MT_Actor : Actor
{
//TODO: Do stuff.
}

Class MT_PlayerWeapon : Weapon
{
Default
{
Weapon.AmmoUse1 0;
Weapon.AmmoUse2 0;
Weapon.AmmoType1 "Clip";
Weapon.AmmoType2 "Clip";
+WEAPON.ALT_AMMO_OPTIONAL;
+WEAPON.AMMO_OPTIONAL;
+WEAPON.DONTBOB;
+INVENTORY.UNDROPPABLE;
+INVENTORY.UNCLEARABLE;
}
	States
	{
	Ready:
		CHGG A 1 A_WeaponReady;
		Loop;
	Deselect:
		CHGG A 1 A_Lower;
		Loop;
	Select:
		CHGG A 1 A_Raise;
		Loop;
	AltFire:
	Fire:
		CHGG AB 4 A_FireCGun;
		CHGG B 0 A_ReFire;
		Goto Ready;
	Flash:
		CHGF A 5 Bright A_Light1;
		Goto LightDone;
		CHGF B 5 Bright A_Light2;
		Goto LightDone;
	Spawn:
		MGUN A -1;
		Stop;
	}
}

//------------------------------------------------------------------------------
//CUSTOM FUNCTIONS
//------------------------------------------------------------------------------
