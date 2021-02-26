Class MT_105mmCannon : MT_BasecannonZS
{

Default
{
Tag "105mm Cannon";
}

/*
override void BeginPlay()
{
	Compitable_Ammo[0] = "MHT_BaseGun_AP";
	Compitable_Ammo[1] = "MHT_BaseGun_APCR";
	Compitable_Ammo[2] = "MHT_BaseGun_HE";
	Compitable_Ammo[3] = "MHT_BaseGun_Bee";
	Compitable_Ammo[4] = "MHT_BaseGun_Chem";
	Super.BeginPlay();
}
*/

//Check what ammo type is loaded in
static bool Func_CheckLoadedAmmo(actor player, string ammo_) 
{
	string AmmoType[5];
	AmmoType[0] = "MHT_BaseGun_AP";
	AmmoType[1] = "MHT_BaseGun_APCR";
	AmmoType[2] = "MHT_BaseGun_HE";
	AmmoType[3] = "MHT_BaseGun_Bee";
	AmmoType[4] = "MHT_BaseGun_Chem";
	
	for (int i = 0; i < 5; i++)
	{
		if (player.CheckInventory(AmmoType[i], 1))
		{
			return True;
		}	
	}
	
	return false;
}

//Check if there is enough ammo
static bool Func_CheckAmmo(actor player, int ammo_)
{
	string AmmoType[5];
	AmmoType[0] = "MT_75x500mmAP";
	AmmoType[1] = "MT_75x500mmAPCR";
	AmmoType[2] = "MT_75x500mmHE";
	AmmoType[3] = "MT_75x500mmBee";
	AmmoType[4] = "MT_75x500mmChem";
	
	if (player.CountInv(AmmoType[ammo_]) > 0)
	{
			return True;
	}	
	
	return false;
}


Action void Func_FireCannon(actor player, int projectile)
{
	string ProjType[5];
	ProjType[0] = "MT_105mmAPHEshell";
	ProjType[1] = "MT_105mmU_APFSDSshell";
	ProjType[2] = "MT_105mmMPHErocket";
	ProjType[3] = "MT_105mmBeeProjectile";
	ProjType[4] = "MT_105mmChemshell";
	
	if (ProjType[projectile] == ProjType[0])
	{ 
		Func_FireAP(player, 0); 
	}
	else if (ProjType[projectile] == ProjType[1])
	{ 
		Func_FireAP(player, 1); 
	}
	else if (ProjType[projectile] == ProjType[2])
	{
		if (CountInv("MTU_HEShell_2") == 0)
		{
			A_FireProjectile("MT_105mmMPHErocket", 0, 0);
		}
		else if (CountInv("MTU_HEShell_2") == 1)
		{
			A_FireProjectile("MT_105mmMPHErocket_2", 0, 0);
		}
		else if (CountInv("MTU_HEShell_2") == 2)
		{
			A_FireProjectile("MT_105mmMPHErocket_2", 0, 0);
		}	
	}
	else if (ProjType[projectile] == ProjType[3])
	{
		Func_FireBee(player);
	}
	else if (ProjType[projectile] == ProjType[4])
	{
		if (CountInv("MTU_ChemShell_2") == 0)
		{
			A_FireProjectile("MT_105mmChemshell", 0, 0);
		}
		else if (CountInv("MTU_ChemShell_2") == 1)
		{
			A_FireProjectile("MT_105mmChemshell", 0, 0);
		}
		else if (CountInv("MTU_ChemShell_2") == 2)
		{
			A_FireProjectile("MT_105mmChemshell", 0, 0);
		}	
	}
	
}

Action void Func_FireAP(actor player, int va) 
{
	string ProjType[6];
	ProjType[0] = "MT_105mmAPHEshell";
	ProjType[1] = "MT_105mmAPHEshell_2";
	ProjType[2] = "MT_105mmAPHEshell_3";
	ProjType[3] = "MT_105mmU_APFSDSshell";
	ProjType[4] = "MT_105mmU_APFSDSshell_2";
	ProjType[5] = "MT_105mmU_APFSDSshell_3";
	
	if (va == 0)
	{
		for (int i = 0; i < 7; i++)
		{
			if (player.CountInv("MTU_APShot_2") == 0)
			{
				A_FireProjectile(ProjType[0], 0, 0);
			}
			else if (player.CountInv("MTU_APShot_2") == 1)
			{
				A_FireProjectile(ProjType[1], 0, 0);	
			}
			else if (player.CountInv("MTU_APShot_2") == 2)
			{
				A_FireProjectile(ProjType[2], 0, 0);
			}
			
		}
		A_FireProjectile("MT_105mmAPHEshell_Dummy", 0, 0);
	}

	else if (va == 1)
	{
		for (int i = 0; i < 9; i++)
		{
			if (player.CountInv("MTU_APShot_2") == 0)
			{
				A_FireProjectile(ProjType[3], 0, 0);
			}
			else if (player.CountInv("MTU_APShot_2") == 1)
			{
				A_FireProjectile(ProjType[4], 0, 0);
			}
			else if (player.CountInv("MTU_APShot_2") == 2)
			{
				A_FireProjectile(ProjType[5], 0, 0);
			}
		}
		A_FireProjectile("MT_105mmU_APFSDSshell_Dummy", 0, 0);
	}

}

Action void Func_FireBee(actor player)
{
	int loop = 1;
	string ProjType[3];
	ProjType[0] = "MT_105mmBeeProjectile";
	ProjType[1] = "MT_105mmBeeProjectile";
	ProjType[2] = "MT_105mmBeeProjectile";
	
	if (player.CountInv("MTU_BuckShotShell_2") == 0)
	{
		Func_FireBeeNow(player, ProjType[0]);
	}
	else if (player.CountInv("MTU_BuckShotShell_2") == 1)
	{
		Func_FireBeeNow(player, ProjType[1]);
	}
	else if (player.CountInv("MTU_BuckShotShell_2") == 2)
	{
		Func_FireBeeNow(player, ProjType[2]);
	}

}

Action void Func_FireBeeNow(actor player, string projectile)
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


States
{

Deselect:
	"####" AAA 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
	"####" A 0 A_TakeInventory("MT_Periscope",2);
	"####" A 0 A_TakeInventory("MT_75x500mmCannon_IsSelected",1);
	"####" A 0 A_ZoomFactor(1.0);
	"####" A 0 A_SetCrosshair(0);
	"####" AAAAAAAAAAAAAAA 0 A_Lower;
	"####" A 1 A_Lower;
	Goto Deselect+4;

Select:
	MCAN A 0;
	MCAN A 0 A_GiveInventory("MT_75x500mmCannon_IsSelected",1);
	MCAN A 0 A_TakeInventory("MT_ReadyJumper",1);
	MCAN A 0 A_Raise;
	Goto BaseJumper;

Ready2:
	"####" A 0;
	"####" A 0 A_JumpIfInventory("75mmReloaded", 1, "Loadedb");

	"####" A 0 {
		bool checker = false;
		
		checker = Func_CheckLoadedAmmo(self, "MHT_BaseGun_AP");
		checker = Func_CheckLoadedAmmo(self, "MHT_BaseGun_APCR");
		checker = Func_CheckLoadedAmmo(self, "MHT_BaseGun_HE");
		checker = Func_CheckLoadedAmmo(self, "MHT_BaseGun_Bee");
		checker = Func_CheckLoadedAmmo(self, "MHT_BaseGun_Chem");
		
		if (checker == true)
		{
			return A_Jump(256, "Ready");
		}
		
		return A_Jump(0, "Ready");
	}
	
	Goto Give;

//Checks what ammo mode is selected and then checks 
//if there is any ammo available at all. 
Give:
	"####" A 0 A_GiveInventory("MHT_BaseGun_AP",1);
	"####" A 0 A_GiveInventory("MHT_BaseGun_AmmoSlot",1);
	Goto Ready;
	
Fire:
	"####" A 0 {	
		string Compitable_Ammo[5];
		Compitable_Ammo[0] = "MHT_BaseGun_AP";
		Compitable_Ammo[1] = "MHT_BaseGun_APCR";
		Compitable_Ammo[2] = "MHT_BaseGun_HE";
		Compitable_Ammo[3] = "MHT_BaseGun_Bee";
		Compitable_Ammo[4] = "MHT_BaseGun_Chem";
	
		if (CountInv("I_75mmReloadTimer1") == 0 && CountInv("MTU_FastCannon_2") == 0 ||
			CountInv("I_75mmReloadTimer2") == 0 && CountInv("MTU_FastCannon_2") > 0 )
		{

			if (CountInv("MTU_FastCannon_2") > 0)
			{
				ACS_NamedExecute("MT_Wfiring_delay", 0, 1, 90);
				A_GiveInventory("I_75mmReloadTimer2", 1);				
			}
			else
			{
				ACS_NamedExecute("MT_Wfiring_delay", 0, 0, 120);
				A_GiveInventory("I_75mmReloadTimer1", 1);			
			}

			if (CountInv(Compitable_Ammo[0]) == 1 && Func_CheckAmmo(self, 0))
			{
				Func_FireCannon(self, 0);
				A_TakeInventory("MT_75x500mmAP", 1);
				return A_Jump(256, "MuzzleFlash_Default");
			}

			else if (CountInv(Compitable_Ammo[1]) == 1 && Func_CheckAmmo(self, 1))
			{
				Func_FireCannon(self, 1);;
				A_TakeInventory("MT_75x500mmAPCR", 1);
				return A_Jump(256, "MuzzleFlash_Default");
			}

			else if (CountInv(Compitable_Ammo[2]) == 1 && Func_CheckAmmo(self, 2))
			{
				Func_FireCannon(self, 2);
				A_TakeInventory("MT_75x500mmHE", 1);
				return A_Jump(256, "MuzzleFlash_Rocket");
			}

			else if (CountInv(Compitable_Ammo[3]) == 1 && Func_CheckAmmo(self, 3))
			{
				Func_FireCannon(self, 3);
				A_TakeInventory("MT_75x500mmBee", 1);
				return A_Jump(256, "MuzzleFlash_Default");
			}
			
			else if (CountInv(Compitable_Ammo[4]) == 1 && Func_CheckAmmo(self, 4))
			{
				Func_FireCannon(self, 4);
				A_TakeInventory("MT_75x500mmChem", 1);
				return A_Jump(256, "MuzzleFlash_Default");
			}
			
		}	
		return A_Jump(0, "Ready");
	}
	Goto Ready;
	
MuzzleFlash_Default:    
	"####" A 0 A_Playsound("HeavyCannon/Firing");
	"####" A 0 A_GunFlash;
	"####" A 0 A_AlertMonsters(5000);
	"####" A 0 A_FireProjectile("75mmFakeMuzzleFlash",0,0,0);
	"####" A 0 A_SpawnItemEx("MT_P_BulletCaseTest_Medium",0,0,8,4,0,5+random(-2,2),180);
	"####" BCDEFG 2;
	Goto Ready;
 
MuzzleFlash_Rocket:    
	"####" A 0 A_Playsound("HeavyCannon/RocketFiring");
	"####" A 0 A_GunFlash;
	"####" A 0 A_AlertMonsters(5000);
	"####" A 0 A_FireProjectile("75mmFakeMuzzleFlash",0,0,0);
	"####" BCDEFG 2;
	Goto Ready;	
	
	}
}
