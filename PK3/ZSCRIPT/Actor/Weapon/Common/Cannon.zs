//------------------------------------------------------------------------------
/* Base Cannon
 * Handles cannon weapons.
 */
//------------------------------------------------------------------------------


Mixin Class Cannon_Def
{


}

Class MT_BaseCannon : MT_BaseweaponZS
{
	//Ammunition def
	//Mixin HUD_Ammo2;

Action void Cannon_Fire(string ProjID, string Fake_ProjID = "", int shoot_count = 1, string FiringSound = "")
{
	A_PlaySound(FiringSound, CHAN_WEAPON);

	if (shoot_count == 1)
	{
		A_FireProjectile(ProjID, 0, 0);
	}
	else if (shoot_count > 1)
	{
		for (int i = 0; i < shoot_count; i++)
		{
			A_FireProjectile(ProjID, 0, 0);
		}	
	}	
	
	if (Fake_ProjID)
	{
		A_FireProjectile(Fake_ProjID, 0, 0);
	}
}


Action void Cannon_BeeFire(string projectile)
{
	int loop = 1;

	//Crosshair center
	A_FireProjectile(projectile, 0, 0, 0, 0, FPF_NOAUTOAIM, +0.1);
	A_FireProjectile(projectile, 0, 0, 0, 0, FPF_NOAUTOAIM, -0.1);
	A_FireProjectile(projectile, 0, 0, 0, 0, FPF_NOAUTOAIM, 0);	

	for (loop; loop < 3; loop++)
	{
		//Up
		A_FireProjectile(projectile, +0.10 * loop, 0, 0, 0, FPF_NOAUTOAIM, +0.1);
		A_FireProjectile(projectile, +0.10 * loop, 0, 0, 0, FPF_NOAUTOAIM, -0.1);
		A_FireProjectile(projectile, +0.14 * loop, 0, 0, 0, FPF_NOAUTOAIM, 0);

		//Down
		A_FireProjectile(projectile, -0.14 * loop, 0, 0, 0, FPF_NOAUTOAIM, 0);
		A_FireProjectile(projectile, -0.10 * loop, 0, 0, 0, FPF_NOAUTOAIM, -0.1);
		A_FireProjectile(projectile, -0.10 * loop, 0, 0, 0, FPF_NOAUTOAIM, +0.1);
	}

}


Default
{
	Weapon.SlotNumber 2;
	Weapon.SlotPriority 1;
	Tag "Base Cannon";
}

States
{

Deselect:
	"####" AAA 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
	"####" A 0 A_TakeInventory("MT_Periscope",2);
	"####" A 0 A_TakeInventory("MT_75x500mmCannon_IsSelected", 1);
	"####" A 0 A_ZoomFactor(1.0);
	"####" A 0 A_SetCrosshair(0);
	"####" AAAAAAAAAAAAAAA 0 A_Lower;
	"####" A 1 A_Lower;
	Goto Deselect+4;


Fire_End:
	"####" BCDEFG 2;
	Goto Ready;


Ready2:
	"####" A 0
	{
		AmmoSwitcher.Set_Gun_Invoker(invoker);
		AmmoSwitcher.Set_AmmoType_Max(invoker.Max_AmmoType);
		GiveInventory("MT_75x500mmCannon_IsSelected", 1);
	}
	Goto Ready;

}



}


