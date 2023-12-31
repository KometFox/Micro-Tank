//------------------------------------------------------------------------------
////Multi Purpose Device
//------------------------------------------------------------------------------
Class MT_MultiPurposeDevice_AmmoSlot : Inventory 
{Default{inventory.maxamount 2;}}

Class MT_MultiPurposeDevice_Repair  : MT_Boolean {}
Class MT_MultiPurposeDevice_Reclaim : MT_Boolean {}

Class MT_Power_RepairSlowdown : PowerSpeed
{
	Default
	{
		Powerup.Duration -5;
		Speed 0.25;
		Powerup.Color "0 0 200", 0.1;
		Inventory.Icon "TNT1";
	}
}

Class Multi_Purpose_Device : MT_BaseweaponZS
{
Mixin Cannon_Ammunition;
//Mixin HUD_Ammo3;
Mixin HUD_Ammo;

S_AmmoDef AmmoTypes[2];


override void PostBeginPlay()
{
	Max_AmmoType = 1;
	WeaponName = "Multi_Purpose_Device";
	
	AmmoTypes[0].AmmoItem = "MT_Spareparts";
	AmmoTypes[0].ProjectileID = "";
	AmmoTypes[0].Fake_ProjectileID = "";
	AmmoTypes[0].FireSound = "HeavyCannon/Firing";
	AmmoTypes[0].Shoots_Per_Proj = 1;
	AmmoTypes[0].Ammo_Name = "Repair";
	AmmoTypes[0].Ammo_Sprite = TexMan.CheckForTexture ("MSPPA0", TexMan.Type_Any); 
	
	AmmoTypes[1].AmmoItem = "Clip";
	AmmoTypes[1].ProjectileID = "";
	AmmoTypes[1].Fake_ProjectileID = "";
	AmmoTypes[1].FireSound = "HeavyCannon/Firing";
	AmmoTypes[1].Shoots_Per_Proj = 1;
	AmmoTypes[1].Ammo_Name = "Reclaim";
	AmmoTypes[1].Ammo_Sprite = TexMan.CheckForTexture ("RURMC0", TexMan.Type_Any); 

	Super.PostBeginPlay();		//invoker.Send_Info2HUD();

}

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


Default
{
  Weapon.SlotNumber 1;
  Weapon.SlotPriority 1;
  Inventory.PickupMessage "$GOTPLASMA";
  Tag "Multi Purpose Device";
  Damagetype "Repair";
  +WEAPON.NOALERT;
}
  States
  {

Deselect:
	"####" AAA 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
	"####" A 0 A_TakeInventory("MT_Periscope",2);
	"####" A 0 A_TakeInventory("MT_MultiPurposeDevice_IsSelected",1);
	"####" A 0; //A_SetInventory("MT_MultiPurposeDevice_Repair", 0)
	"####" A 0; //A_SetInventory("MT_MultiPurposeDevice_Reclaim", 0)
	"####" A 0 A_ZoomFactor(1.0);
	"####" A 0 A_SetCrosshair(0);
	"####" AAAAAAAAAAAAAAA 0 A_Lower;
	"####" A 1 A_Lower;
	Goto Deselect+4;

Select:
	MCAN A 0;
	MCAN A 0 A_GiveInventory("MT_MultiPurposeDevice_IsSelected",1);
	MCAN A 0 A_TakeInventory("MT_ReadyJumper",1);
	MCAN A 0 A_Raise;
    Goto BaseJumper;
	
Ready2:
	"####" A 0
	{	
		AmmoSwitcher.Set_Gun_Invoker(invoker);
		AmmoSwitcher.Set_AmmoType_Max(invoker.Max_AmmoType);
	}
    "####" A 0 A_JumpIfInventory("MT_MultiPurposeDevice_Repair"        ,1, "Ready");
    "####" A 0 A_JumpIfInventory("MT_MultiPurposeDevice_Reclaim"      ,1, "Ready");
	Goto Give;
	
//Checks what ammo mode is selected and then checks 
//if there is any ammo available at all. 
Give:
    "####" A 0 A_GiveInventory("MT_MultiPurposeDevice_Repair",1);
	"####" A 0 A_GiveInventory("MT_MultiPurposeDevice_AmmoSlot",1);
	Goto Ready;
	
Fire:  
	"####" A 0
	{
		/*
		if (CheckInventory("MT_MultiPurposeDevice_Repair", 0) == 1)
			{return A_Jump(256, "Repair");}
		else if (CheckInventory("MT_MultiPurposeDevice_Reclaim", 0) == 1)
			{return A_Jump(256, "Reclaim");}
		return A_Jump(256, "Ready");
		*/
		
		if (Invoker.Loaded_Projectile == 0)
			{return A_Jump(256, "Repair");}
		else if (Invoker.Loaded_Projectile == 1)
			{return A_Jump(256, "Reclaim");}
			
		return A_Jump(256, "Ready");		
	}
	"####" BCDE 2;
	Goto Ready;
		
Reclaim2:
    "####" A 0 A_Playsound("MultiPurposeDevice/Reclaim");
    Goto Reclaim;

//Reclaim
Reclaim:
	"####" A 0 A_RailAttack(10, 0, 0, 0, 0, RGF_SILENT|RGF_NOPIERCING|RGF_NORANDOMPUFFZ, 0.5, "", 0.5, 0.5, 600, 25, 5, 1.5, "ReclaimEffect");
	"####" A 0 A_FireBullets(0, 0, 1, 0, "ReclaimEffect_Impact", FBF_NORANDOMPUFFZ, 600);
	"####" E 2;
    "####" E 0 A_Jump(32,"Reclaim2");
    "####" E 0 A_ReFire("Reclaim");
	"####" EDCBA 2;
    Goto Ready;

//Repair
Repair:
	"####" A 0 A_JumpIf(CallACS("MT_CheckMaxHealth") == 0, "Repair_Ammocheck");
	Goto Ready;
	
Repair_Ammocheck:
	"####" A 0 A_JumpIfInventory("MT_Spareparts", 10, "Repair_Now");
	Goto Ready;
	
Repair_Now:    
	"####" A 0 Healthing(10,0);
	"####" A 0 A_TakeInventory("MT_Spareparts", 10);
	"####" A 0 A_GiveInventory("MT_Power_RepairSlowdown",1);
	"####" AAA 1 A_SpawnItem("MDPFakeMuzzleFlash",0,0,0);
    "####" A 0 A_SpawnItem("MDPFakeMuzzleFlash",0,0,1);
    "####" A 0 A_PlaySound("MultiPurposeDevice/Repair");
	"####" A 1;
    Goto Ready;
	
MaxHealth:
	"####" A 0 A_Print("Health is at max, aborting.");
	Goto Ready;

Flash:
    "####" A 0 A_FireProjectile("MDPFakeMuzzleFlash",0,0,0);
    "####" A 4 Bright A_Light1;
    Goto LightDone;
	
Spawn:
    0MED A -1;
    Stop;
  }
}