//Delay constants
const w75mmCannon_Delay1 = 120;
const w75mmCannon_Delay2 = 90;

const wHPepperpot_Delay1 = 25;
const wHPepperpot_Delay2 = 20;

/*
TODO: Fix Deselect/Select animation
*/
//------------------------------------------------------------------------------
////Baseweapon
//------------------------------------------------------------------------------
Class MT_BaseweaponZS : MT_PlayerWeapon
{
Default 
{
Weapon.AmmoUse1 0;
Weapon.AmmoUse2 1;
Weapon.AmmoType1 "";
Weapon.AmmoType2 "A_7u62x54mmR";
+WEAPON.CHEATNOTWEAPON;
Inventory.PickupMessage "The weapon is supposed to be used as a base to inherit from.";
Tag "Baseweapon";
}
States
{
Spawn:
    CAAB A -1;
    Stop;

//Initalization states
BaseJumper:
	TNT1 A 0; 
	TNT1 A 0 A_JumpIfInventory("MT_Subgun_LightMG",1,"MD3_LMG");
	TNT1 A 0 A_JumpIfInventory("MT_Subgun_HeavyMG",1,"MD3_HMG");
	MCAN A 0;
	Goto BaseJumper_End;
MD3_LMG: //Light Machinegun
	MCAN A 0;
	Goto BaseJumper_End;
MD3_HMG: //Heavy Machinegun
	MCA1 A 0;
	Goto BaseJumper_End;
BaseJumper_End:
	"####" A 0 A_JumpIfInventory("MT_ReadyJumper",1,"RealReady");
	Goto SelectAnim;
		
Ready:
	TNT1 A 0;
    Goto BaseJumper;	
			
Select:
	MCAN A 0 A_TakeInventory("MT_ReadyJumper",1);
	MCAN A 0 A_Raise;
    Goto BaseJumper;
				
Deselect:
	"####" AAA 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
	"####" A 0 A_TakeInventory("MT_Periscope",2);
	"####" A 0;
	"####" A 0 A_ZoomFactor(1.0);
	"####" A 0 A_SetCrosshair(0);
	"####" AAAAAAAAAAAAAAA 0 A_Lower;
	"####" A 1 A_Lower;
	Goto Deselect+4;

SelectAnim:
	"####" A 0 A_PlaySoundEx("V_Interact/SwitchGun","SoundSlot5");
	"####" A 0;
	"####" A 0 A_GiveInventory("MT_ReadyJumper",1);
	"####" AA 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
	"####" A 0 A_Raise;
	"####" A 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);	
	Loop;

RealReady:
	"####" A 1 A_WeaponReady(WRF_ALLOWRELOAD);
    "####" A 0 A_JumpIfInventory("MT_Periscope",1,"Zoom1");
	"####" A 0 A_Jump(256,"Ready2"); //For some reason Goto Ready2 is bugged on inherited weapons
	Goto Ready2;
	
//REPLACE ME
Ready2:
	"####" A 0;
	Goto RealReady;

//Blank firing. REPLACE ME
Fire:
	"####" A 0;
	Goto Ready;
   
//------------------------------------------------------------------------------
////Periscope State
//------------------------------------------------------------------------------
Zoom1:
	"####" A 0 A_ZoomFactor(2.25);
	"####" A 0 A_JumpIfInventory("MT_Periscope",2,"Zoom2");
	"####" A 0 A_SetCrosshair(99);
	Goto Ready;
Zoom2:
	"####" A 0 A_ZoomFactor(4.5);
	"####" A 0 A_JumpIfInventory("MT_Periscope",3,"ZoomOut");
	"####" A 0 A_SetCrosshair(99);
	Goto Ready;
ZoomOut:
	"####" A 0 A_ZoomFactor(1.0);
	"####" A 0 A_TakeInventory("MT_Periscope",5);
	"####" A 0 A_SetCrosshair(0);
	Goto Ready;
	
//------------------------------------------------------------------------------
////Subgun checker
//------------------------------------------------------------------------------
AltFire:
    "####" A 0 A_JumpIfInventory("MT_Subgun_HeavyMG",1,"AltFire_HMG_Ammo");
	"####" A 0 A_JumpIfInventory("MT_Subgun_LightMG",1,"AltFire_LMG_Ammo");
	Goto AltFire_LMG_Ammo;

AltFire_HMG_Ammo:
    "####" A 0 A_JumpIfInventory("A_7u62x54mmR", 3, "AltFire_HMG_N");
	Goto AltFire_Empty;

AltFire_LMG_Ammo:
    "####" A 0 A_JumpIfInventory("A_7u62x54mmR", 1, "AltFire_LMG_N");
	Goto AltFire_Empty;

//------------------------------------------------------------------------------
////Light Machinegun
//------------------------------------------------------------------------------
AltFire_Empty:
    "####" A 8;
    "####" A 0 A_Print("There is no Coax-MG ammo left!");
    "####" A 0 A_PlaySound("GCrew/MGEmpty");
	Goto Ready;
	
AltFire_LMG_N:  
    "####" A 0 A_Playsound("LMachinegun/Fire");
    "####" A 0 A_GunFlash;
    "####" A 0 A_AlertMonsters(300);
	"####" A 0 A_FireProjectile("MT_MGMuzzleFlash",0,0,0);
	"####" A 0; //A_TakeInventory("A_7u62x54mmR", 1)
    "####" H 2;
	"####" I 1;
	"####" A 0 A_WeaponReady;
    Goto Altfire_LMG_Fire;

Altfire_LMG_Fire:
	"####" A 0 
	{
		if (CheckInventory("MTU_APShot_2", 0) == 2)
		{
			A_FireProjectile("7.62x54mm AP 3",+frandom(-0.15,0.15),1,0,0,0,+frandom(-0.15,0.15));
		}
		else if (CheckInventory("MTU_APShot_2", 0) == 1)
		{
			A_FireProjectile("7.62x54mm AP 2",+frandom(-0.15,0.15),1,0,0,0,+frandom(-0.15,0.15));
		}
		else	
		{
			A_FireProjectile("7.62x54mm AP",+frandom(-0.15,0.15),1,0,0,0,+frandom(-0.15,0.15));
		}
	}
	"####" A 0 A_WeaponReady;
	"####" A 0 A_ReFire;
	Goto Altfire_LMG_End;

Altfire_LMG_End:
	"####" JKL 2;
	"####" A 0 A_WeaponReady;
    Goto Ready;
//------------------------------------------------------------------------------
////Heavy Machinegun
//------------------------------------------------------------------------------
AltFire_HMG_N:  
    "####" A 0 A_Playsound("HMachinegun/Fire");
    "####" A 0 A_GunFlash;
    "####" A 0 A_AlertMonsters(350);
	"####" A 0 A_FireProjectile("MT_MGMuzzleFlash",0,0,0);
	"####" A 0 A_TakeInventory("A_7u62x54mmR", 2);
    Goto Altfire_HMG_Fire;

Altfire_HMG_Fire:
	"####" A 0 
	{
		if (CheckInventory("MTU_APShot_2", 0) == 2)
		{
			A_FireProjectile("12.7x99mm_AP3",+frandom(-0.15,0.15),1,0,0,0,+frandom(-0.15,0.15));
		}
		else if (CheckInventory("MTU_APShot_2", 0) == 1)
		{
			A_FireProjectile("12.7x99mm_AP2",+frandom(-0.15,0.15),1,0,0,0,+frandom(-0.15,0.15));
		}
		else	
		{
			A_FireProjectile("12.7x99mm_AP",+frandom(-0.15,0.15),1,0,0,0,+frandom(-0.15,0.15));
		}
	}
    "####" H 2;
	"####" I 2;
	"####" A 0 A_ReFire;
	Goto Altfire_HMG_End;

Altfire_HMG_End:
	"####" JKL 0;
    Goto Ready;

Flash:
	"####" A 0;
    Goto LightDone;
AltFlash:
    "####" A 0;
    Goto LightDone;
	
	}
}

//----------------------------------------------------------------------------**
//
//----------------------------------------------------------------------------**
Class MT_BasecannonZS : MT_BaseweaponZS
{
Default
{
+WEAPON.CHEATNOTWEAPON;
Inventory.PickupMessage "The weapon is supposed to be used as a base to inherit from.";
Tag "Baseweapon";
}
States
{
//REPLACE ME
Ready2:
	"####" A 0;
	Goto RealReady;

//Blank firing. REPLACE ME
Fire:
	"####" A 0;
	Goto Ready;

//------------------------------------------------------------------------------
////Loading, Ammunition
//------------------------------------------------------------------------------
StillLoading:
    "####" A 1;
	"####" A 0 A_PlaySound("GCrew/StillLoading");
	Goto Ready;
Empty:
    "####" A 0 A_Print("There is no Tank Grenades left!");
	"####" A 8;
	"####" A 0 A_PlaySound("GCrew/CannonEmpty");
	"####" A 0 A_Jump(256, "Ready2");
	Goto Ready2;
Loadedb:
    "####" A 0;
	"####" A 0 A_TakeInventory("75mmReloaded", 99);
	"####" A 0 A_Playsound("H_Cannon/Loaded", 3);
	Goto Ready;
Loadedb2:
    "####" A 0;
	"####" A 0 A_TakeInventory("75mmReloaded", 99);
	"####" A 0 A_Playsound("H_Cannon/Loaded", 3);
	Goto Ready;
	
//------------------------------------------------------------------------------
////Muzzleflash
//------------------------------------------------------------------------------
Flash:
	"####" A 0;
    Goto LightDone;
AltFlash:
    "####" A 0;
    Goto LightDone;

MuzzleFlash_Default:    
   "####" A 0 A_Playsound("HeavyCannon/Firing");
   "####" A 0 A_GunFlash;
   "####" A 0 A_AlertMonsters(2500);
   "####" A 0 A_FireProjectile("75mmFakeMuzzleFlash",0,0,0);
   "####" A 0 A_SpawnItemEx("MT_P_BulletCaseTest_Medium",0,0,8,4,0,5+random(-2,2),180);
   "####" BCDEFG 2;
   "####" A 0 A_JumpIfInventory("MTU_FastCannon_2",1,"MuzzleFlash3");
   Goto Ready2;    
	}
}



//----------------------------------------------------------------------------**
////Common Heavy Weapon
//----------------------------------------------------------------------------**

//----------------------------------------------------------------------------**
////Common Medium Weapon
//----------------------------------------------------------------------------**

//----------------------------------------------------------------------------**
////Common Light Weapon
//----------------------------------------------------------------------------**


//------------------------------------------------------------------------------
////Multi Purpose Device
//------------------------------------------------------------------------------

Class Multi_Purpose_Device : MT_BaseweaponZS
{
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
	"####" A 0;
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
		if (CheckInventory("MT_MultiPurposeDevice_Repair", 0) == 1)
			{return A_Jump(256, "Repair");}
		else if (CheckInventory("MT_MultiPurposeDevice_Reclaim", 0) == 1)
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
