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

//------------------------------------------------------------------------------
//PROJECTILES
//------------------------------------------------------------------------------
/* 
	Source: panzerworld.com/5-cm-kw-k
	5cm Kampfwagenkanone 
	MV = M/S
	Mass = G
	
	Panzergranate Patrone APHE
	Muzzlevelocity = 685 
	Mass = 2060
	Explosivemass = 17
	ExplosiveType = Np.10
	
	Panzergranate Patrone 40 (APCR)
	Muzzlevelocity = 1050
	Mass = 925
	ExplosiveMass = 0
	
	Sprenggranate Patrone 38 (HE)
	MuzzleVelocity = 450
	Mass = 1820	
	ExplosiveMass = 170
	ExplosiveType = Np.10
*/

Class MT_50mmAPHE_Shell : MT_FastProjectile
{
	
	Default
	{
		DamageFunction (546);
		DeathSound "Medium/APExplosion";
		MT_FastProjectile.SplashDamage 150;
		MT_FastProjectile.SplashRadius 100;
		MT_FastProjectile.SplashFRadius 75;
		MT_FastProjectile.SoftEffect "CFG_MediumShell_APHE"; 
		MT_FastProjectile.HardEffect "CFG_MediumShell_APHE";
		MT_FastProjectile.ImpactEffect "CFG_MediumShell_APHE";
	}
}

Class MT_50mmAPCR_Shell : MT_FastProjectile
{
	Mixin MultiPiercing;

	Default
	{
		DamageFunction (790);
		DeathSound "Medium/APExplosion";
		MT_FastProjectile.SplashDamage 60;
		MT_FastProjectile.SplashRadius 30;
		MT_FastProjectile.SplashFRadius 15;	
		MT_FastProjectile.SoftEffect "CFG_MediumShell_APHE"; 
		MT_FastProjectile.HardEffect "CFG_MediumShell_APHE";
		MT_FastProjectile.ImpactEffect "CFG_MediumShell_APHE";
	}
}

Class MT_50mmHE_Shell : MT_FastProjectile
{

	Default
	{
		DamageFunction (42);
		DeathSound "Medium/Explosion";
		MT_FastProjectile.SplashDamage 300;
		MT_FastProjectile.SplashRadius 200;
		MT_FastProjectile.SplashFRadius 130;	
		MT_FastProjectile.SoftEffect "CFG_MediumShell_HE"; 
		MT_FastProjectile.HardEffect "CFG_MediumShell_HE";
		MT_FastProjectile.ImpactEffect "CFG_MediumShell_HE";
	}
}


