Class MT_50mmCannon_Timer1 : MT_TimerBase
{
Default
{
Inventory.MaxAmount 95;
Inventory.InterHubAmount 95;
}
}

Class MT_50mmCannon_Timer2 : MT_TimerBase
{
Default
{
Inventory.MaxAmount 80;
Inventory.InterHubAmount 80;
}
}

Class MT_50mmCannon : MT_BaseCannon
{

	Mixin Cannon_Ammunition;
	//Mixin Cannon_Def;
	//Mixin HUD_Ammo;
	Mixin HUD_Ammo;

	S_AmmoDef AmmoTypes[3];

override void Tick()
{
	Super.Tick();
	
	if (Active == True)
	{
		Send_Info2HUD(
				AmmoTypes[Loaded_Projectile].Ammo_Name,
				AmmoTypes[Loaded_Projectile].Ammo_Sprite,
				AmmoTypes[Loaded_Projectile].AmmoItem);
	}
}

override void PostBeginPlay()
{
	Max_AmmoType = 2;
	
	//Define the ammunition
	//APHE
	AmmoTypes[0].AmmoItem = "MT_75x500mmAP";
	AmmoTypes[0].ProjectileID = "MT_50mmAPHE_Shell";
	AmmoTypes[0].Fake_ProjectileID = "";
	AmmoTypes[0].FireSound = "HeavyCannon/Firing";
	AmmoTypes[0].Shoots_Per_Proj = 1;
	AmmoTypes[0].Ammo_Name = "APHE";
	AmmoTypes[0].Ammo_Sprite = TexMan.CheckForTexture ("APAMA0", TexMan.Type_Any); 
	//APCR
	AmmoTypes[1].AmmoItem = "MT_75x500mmAPCR";
	AmmoTypes[1].ProjectileID = "MT_50mmAPCR_Shell";
	AmmoTypes[1].Fake_ProjectileID = "";
	AmmoTypes[1].FireSound = "HeavyCannon/Firing";
	AmmoTypes[1].Shoots_Per_Proj = 1;
	AmmoTypes[1].Ammo_Name = "APCR";
	AmmoTypes[1].Ammo_Sprite = TexMan.CheckForTexture ("ACAMA0", TexMan.Type_Any); 
	//HE
	AmmoTypes[2].AmmoItem = "MT_75x500mmHE";
	AmmoTypes[2].ProjectileID = "MT_50mmHE_Shell";
	AmmoTypes[2].FireSound = "HeavyCannon/Firing";
	AmmoTypes[2].Shoots_Per_Proj = 1;
	AmmoTypes[2].Ammo_Name = "HE";
	AmmoTypes[2].Ammo_Sprite = TexMan.CheckForTexture ("HEAMA0", TexMan.Type_Any); 

	Super.PostBeginPlay();
}

Default
{
	Tag "50mm Cannon";
}

States
{

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
		if (CountInv("MT_50mmCannon_Timer1") == 0 && 
			CountInv("MT_50mmCannon_Timer2") == 0)
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
			GiveInventory("MT_50mmCannon_Timer1", 1);
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

