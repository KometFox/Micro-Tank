Class MT_90mmCannon_Timer1 : MT_TimerBase
{
Default
{
Inventory.MaxAmount 120;
Inventory.InterHubAmount 120;
}
}

Class MT_90mmCannon_Timer2 : MT_TimerBase
{
Default
{
Inventory.MaxAmount 90;
Inventory.InterHubAmount 90;
}
}

Class MT_90mmCannon : MT_BaseCannon
{

	Mixin Cannon_Ammunition;
	//Mixin Cannon_Def;
	Mixin HUD_Cannon;

	S_AmmoDef AmmoTypes[4];


override void PostBeginPlay()
{
	Max_AmmoType = 3;
	AmmoSwitcher.Set_AmmoType_Max(Max_AmmoType);

	//Define the ammunition
	//APHE
	AmmoTypes[0].AmmoItem = "MT_75x500mmAP";
	AmmoTypes[0].ProjectileID = "MT_105mmAPHEshell";
	AmmoTypes[0].Fake_ProjectileID = "MT_105mmAPHEshell_Dummy";
	AmmoTypes[0].FireSound = "HeavyCannon/Firing";
	AmmoTypes[0].Shoots_Per_Proj = 7;
	AmmoTypes[0].Ammo_Name = "APHE";
	AmmoTypes[0].Ammo_Sprite = TexMan.CheckForTexture ("APAMA0", TexMan.Type_Any); 
	//APFSDS
	AmmoTypes[1].AmmoItem = "MT_75x500mmAPCR";
	AmmoTypes[1].ProjectileID = "MT_105mmU_APFSDSshell";
	AmmoTypes[1].Fake_ProjectileID = "MT_105mmU_APFSDSshell_Dummy";
	AmmoTypes[1].FireSound = "HeavyCannon/Firing";
	AmmoTypes[1].Shoots_Per_Proj = 9;
	AmmoTypes[1].Ammo_Name = "U-APFSDS";
	AmmoTypes[1].Ammo_Sprite = TexMan.CheckForTexture ("ACAMA0", TexMan.Type_Any); 
	//HEMP
	AmmoTypes[2].AmmoItem = "MT_75x500mmHE";
	AmmoTypes[2].ProjectileID = "MT_105mmMPHErocket";
	AmmoTypes[2].FireSound = "HeavyCannon/RocketFiring";
	AmmoTypes[2].Shoots_Per_Proj = 1;
	AmmoTypes[2].Ammo_Name = "HEMP";
	AmmoTypes[2].Ammo_Sprite = TexMan.CheckForTexture ("HEAMA0", TexMan.Type_Any); 
	//Bee
	AmmoTypes[3].AmmoItem = "MT_75x500mmBee";
	AmmoTypes[3].ProjectileID = "MT_105mmBeeProjectile";
	AmmoTypes[3].FireSound = "HeavyCannon/Firing";
	AmmoTypes[3].Shoots_Per_Proj = 2;
	AmmoTypes[3].Ammo_Name = "Bee";
	AmmoTypes[3].Ammo_Sprite = TexMan.CheckForTexture ("BHAMA0", TexMan.Type_Any);
	
	Super.PostBeginPlay();
}


override void Tick()
{
	//Get the current value
	Loaded_Projectile = AmmoSwitcher.Get_Ammo_Selected();

	//Dirty fix...
	if (Loaded_Projectile > 3)
	{
		Loaded_Projectile = 0;
	}

	
	Send_Info2HUD(AmmoTypes[Loaded_Projectile].Ammo_Name, 
				AmmoTypes[Loaded_Projectile].Ammo_Sprite,
				AmmoTypes[Loaded_Projectile].AmmoItem);

	super.Tick();
}



Default
{
	Tag "90mm Cannon";
}

States
{

Ready2:
	"####" A 0;
	Goto RealReady;

Fire:
	"####" A 1;
	"####" A 0
	{
		if (CountInv(invoker.AmmoTypes[invoker.Loaded_Projectile].AmmoItem) > 0)
		{
			Return A_Jump(256, "Fire_Now");
		}
		
		Return A_Jump(0, "Ready");
	}
	Goto RealReady;

Fire_Now:
	"####" A 0 
	{
		if (CountInv("MT_90mmCannon_Timer1") == 0 && 
			CountInv("MT_90mmCannon_Timer2") == 0)
		{
			if (invoker.Loaded_Projectile != 3)
			{
				Cannon_Fire(
					invoker.AmmoTypes[invoker.Loaded_Projectile].ProjectileID,
					invoker.AmmoTypes[invoker.Loaded_Projectile].Fake_ProjectileID,
					invoker.AmmoTypes[invoker.Loaded_Projectile].Shoots_Per_Proj,
					invoker.AmmoTypes[invoker.Loaded_Projectile].FireSound);
			}
			else
			{
				Cannon_BeeFire(
					invoker.AmmoTypes[invoker.Loaded_Projectile].ProjectileID);
				
				A_PlaySound(invoker.AmmoTypes[invoker.Loaded_Projectile].FireSound);
			}
			
			TakeInventory(invoker.AmmoTypes[invoker.Loaded_Projectile].AmmoItem, 1);
			GiveInventory("MT_90mmCannon_Timer1", 1);
			Return A_Jump(256, "Fire_End");
		}

		Return A_Jump(0, "Ready");
	}
	Goto RealReady;

Loaded:
	"####" A 0;
	"####" A 0;
	Goto RealReady;

}



}