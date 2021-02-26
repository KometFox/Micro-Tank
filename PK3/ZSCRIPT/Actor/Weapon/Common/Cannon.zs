//------------------------------------------------------------------------------
/* Base Cannon
 * Handles cannon weapons.
 */
//------------------------------------------------------------------------------


//Subclasses needs to modifiy these variables, used for static array
Mixin Class Cannon_Ammunition
{
	Struct S_AmmoDef
	{
		//For weapon
		String ProjectileID, Fake_ProjectileID;
		String AmmoItem, FireSound;
		int Shoots_Per_Proj;
		//For graphic
		String Ammo_Name;
		TextureID Ammo_Sprite;
	}
} 

Mixin Class Cannon_Def
{

}

//Subclasses for sending info to EventHandler renderoverlay
Mixin Class HUD_Cannon
{

	
	void Send_Info2HUD(string name_, TextureID ID, string AmmoItem)
	{
		HUD_AmmoDisplay.Set_AmmoName(name_);
		HUD_AmmoDisplay.Set_Sprite(ID);
		HUD_AmmoDisplay.Set_AmmoItem(AmmoItem);
	}
	

}

Class MT_BaseCannon : MT_BaseweaponZS
{
	//Ammunition def
	int Loaded_Projectile;
	int Max_AmmoType;


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

	A_FireProjectile(projectile, 0, 0, 0, 0, FPF_NOAUTOAIM, +0.1);
	A_FireProjectile(projectile, 0, 0, 0, 0, FPF_NOAUTOAIM, -0.1);
	A_FireProjectile(projectile, 0, 0, 0, 0, FPF_NOAUTOAIM, 0);	

	for (loop; loop < 3; loop++)
	{
		A_FireProjectile(projectile, +0.10 * loop, 0, 0, 0, FPF_NOAUTOAIM, +0.1);
		A_FireProjectile(projectile, +0.10 * loop, 0, 0, 0, FPF_NOAUTOAIM, -0.1);
		A_FireProjectile(projectile, +0.14 * loop, 0, 0, 0, FPF_NOAUTOAIM, 0);

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


Select:
	MCAN A 0
	{
		AmmoSwitcher.Set_AmmoType_Max(invoker.Max_AmmoType);
		GiveInventory("MT_75x500mmCannon_IsSelected", 1);
	}
	MCAN A 0 A_Raise;
	Goto BaseJumper;


Ready2:
	"####" A 0
	{
		//Send how many ammo type this weapon has
		AmmoSwitcher.Set_AmmoType_Max(invoker.Max_AmmoType);		
	}
	Goto Ready;

/*Note: Do not forget to add this function.*/
//Get the current value
//invoker.Loaded_Projectile = AmmoSwitcher.Get_Ammo_Selected();



Fire_End:
	"####" BCDEFG 2;
	Goto Ready;


}



}


