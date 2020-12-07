Class MT_105mmBeeHiveCount0_ZS : Inventory
{
Default
{
Inventory.Amount 1;
Inventory.MaxAmount 5;
}
}

const BEE_PROJFLAG = FPF_NOAUTOAIM;


Class MT_105mmCannon : MT_BasecannonZS
{
Default
{
Weapon.SlotNumber 2;
Weapon.SlotPriority 1;
Inventory.PickupMessage "What the hell.";
Tag "(Int) 105mm Cannon";
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
	"####" A 0 A_JumpIfInventory("75mmReloaded"        ,1, "Loadedb");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_AP"        ,1, "Ready");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_APCR"      ,1, "Ready");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_HE"        ,1, "Ready");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_Bee"      ,1, "Ready");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_Chem"      ,1, "Ready");
	Goto Give;

//Checks what ammo mode is selected and then checks 
//if there is any ammo available at all. 
Give:
	"####" A 0 A_GiveInventory("MHT_BaseGun_AP",1);
	"####" A 0 A_GiveInventory("MHT_BaseGun_AmmoSlot",1);
	Goto Ready;
	
Fire:
	"####" A 0;
	"####" A 0 A_Jumpifinventory("MTU_FastCannon_2",1, "Fire_Fast");
	"####" A 0 A_Jumpifinventory("I_75mmReloadTimer1",1, "StillLoading");
	Goto FireNow;
Fire_Fast:
	"####" A 0 A_Jumpifinventory("I_75mmReloadTimer2",1, "StillLoading");
	"####" A 0;
	Goto FireNow;
	
FireNow:	
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_AP"        ,1, "AP_Fire_Check");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_APCR"      ,1, "APCR_Fire_Check");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_HE"        ,1, "HE_Fire_Check");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_Bee"      ,1, "Bee_Fire_Check");
	"####" A 0 A_JumpIfInventory("MHT_BaseGun_Chem"      ,1, "Chemical_Fire_Check");
	Goto Ready;
   
//It is mandatory they are isolated   
AP_Fire_Check:
	"####" A 0 A_JumpIfInventory("MT_75x500mmAP",1,"APHE_Fire");
	Goto Empty;

APCR_Fire_Check:
	"####" A 0 A_JumpIfInventory("MT_75x500mmAPCR",1,"U_APFSDS_Fire");
	Goto Empty;
  
HE_Fire_Check:
	"####" A 0 A_JumpIfInventory("MT_75x500mmHE",1,"MPHE_Fire");
	Goto Empty;
	
Bee_Fire_Check:
	"####" A 0 A_JumpIfInventory("MT_75x500mmBee",1, "Bee_Fire");
	Goto Empty;

Chemical_Fire_Check:
	"####" A 0 A_JumpIfInventory("MT_75x500mmChem",1, "Chemical_Fire");
	Goto Empty;
	
Flash:
	"####" A 0;
	Goto LightDone;

MuzzleFlash2:
	"####" A 0 A_GiveInventory("I_75mmReloadTimer1", 1);
	"####" A 0 ACS_NamedExecute("MT_Wfiring_delay", 0, 0, w75mmCannon_Delay1);
	Goto Ready;
MuzzleFlash3:
	"####" A 0 A_GiveInventory("I_75mmReloadTimer2", 1);
	"####" A 0 ACS_NamedExecute("MT_Wfiring_delay", 0, 1, w75mmCannon_Delay2);
	Goto Ready;
MuzzleFlash_Default:    
	"####" A 0 A_Playsound("HeavyCannon/Firing");
	"####" A 0 A_GunFlash;
	"####" A 0 A_AlertMonsters(5000);
	"####" A 0 A_FireProjectile("75mmFakeMuzzleFlash",0,0,0);
	"####" A 0 A_SpawnItemEx("MT_P_BulletCaseTest_Medium",0,0,8,4,0,5+random(-2,2),180);
	"####" BCDEFG 2;
	"####" A 0 A_JumpIfInventory("MTU_FastCannon_2",1,"MuzzleFlash3");
	Goto MuzzleFlash2;
 
MuzzleFlash_Rocket:    
	"####" A 0 A_Playsound("HeavyCannon/RocketFiring");
	"####" A 0 A_GunFlash;
	"####" A 0 A_AlertMonsters(5000);
	"####" A 0 A_FireProjectile("75mmFakeMuzzleFlash",0,0,0);
	"####" BCDEFG 2;
	"####" A 0 A_JumpIfInventory("MTU_FastCannon_2",1,"MuzzleFlash3");
	Goto MuzzleFlash2;
	
APHE_Fire:
	"####" A 0 A_TakeInventory("MT_75x500mmAP",1);
	"####" A 0 A_Jumpifinventory("MTU_APShot_2",2, "APHE3_Fire");
	"####" A 0 A_Jumpifinventory("MTU_APShot_2",1, "APHE2_Fire");
	"####" AAAAAAA 0 A_FireProjectile("MT_105mmAPHEshell",0,0);
	"####" A 0 A_FireProjectile("MT_105mmAPHEshell_Dummy",0,1);
	Goto MuzzleFlash_Default;

U_APFSDS_Fire:
	"####" A 0 A_TakeInventory("MT_75x500mmAPCR",1);
	"####" A 0 A_Jumpifinventory("MTU_APShot_2",2, "U_APFSDS3_Fire");
	"####" A 0 A_Jumpifinventory("MTU_APShot_2",1, "U_APFSDS2_Fire");
	"####" AAAAAAAAA 0 A_FireProjectile("MT_105mmU_APFSDSshell",0,0);
	"####" A 0 A_FireProjectile("MT_105mmU_APFSDSshell_Dummy",0,1);
	Goto MuzzleFlash_Default;

MPHE_Fire:
	"####" A 0 A_TakeInventory("MT_75x500mmHE",1);
	"####" A 0 A_Jumpifinventory("MTU_HEShell_2",2, "MPHE3_Fire");
	"####" A 0 A_Jumpifinventory("MTU_HEShell_2",1, "MPHE2_Fire");
	"####" A 0 A_FireProjectile("MT_105mmMPHErocket",0,1,0,0,0);
	Goto MuzzleFlash_Rocket;
 
Bee_Fire:
	"####" A 0 A_TakeInventory("MT_75x500mmBee",1);
	"####" A 0 A_Jumpifinventory("MTU_BuckShotShell_2",2, "Bee3_FireA");
	"####" A 0 A_Jumpifinventory("MTU_BuckShotShell_2",1, "Bee2_FireA");
	"####" A 0;
	Goto Bee_FireA;
	
Bee_FireA:
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, +0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, 0);
	Goto Bee_FireB;

Bee_FireB:
	"####" A 0 A_JumpIf(CountInv("MT_105mmBeeHiveCount0_ZS") >= 2, "Clear");
	"####" A 0 A_GiveInventory("MT_105mmBeeHiveCount0_ZS", 1);
	
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, +0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.14 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, 0);

	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.14 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, 0);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, +0.1);
	loop;

Chemical_Fire:
	"####" A 0 A_TakeInventory("MT_75x500mmChem",1);
	"####" A 0 A_Jumpifinventory("MTU_ChemShell_2",2, "Chemi3_Fire");
	"####" A 0 A_Jumpifinventory("MTU_ChemShell_2",1, "Chemi2_Fire");	
	"####" A 0 A_FireProjectile("MT_105mmChemshell",0,1,0,0,0);
	Goto MuzzleFlash_Default;
	 
////-------------
//Upgrades
////-------------
//Armor Piercing High Explosive
APHE2_Fire:
	"####" AAAAAAA 0 A_FireProjectile("MT_105mmAPHEshell_2",0,0);
	"####" A 0 A_FireProjectile("MT_105mmAPHEshell_Dummy",0,1); 
	Goto MuzzleFlash_Default;
 
APHE3_Fire:
	"####" AAAAAAA 0 A_FireProjectile("MT_105mmAPHEshell_3",0,0);
	"####" A 0 A_FireProjectile("MT_105mmAPHEshell_Dummy",0,1);
	Goto MuzzleFlash_Default;
  
//Uranium Armor Piercing Fin Stabilized Discarding Sabot
U_APFSDS2_Fire:
	"####" AAAAAAAAA 0 A_FireProjectile("MT_105mmU_APFSDSshell_2",0,0);
	"####" A 0 A_FireProjectile("MT_105mmU_APFSDSshell_Dummy",0,1);  
	Goto MuzzleFlash_Default;
 
U_APFSDS3_Fire:
	"####" AAAAAAAAA 0 A_FireProjectile("MT_105mmU_APFSDSshell_3",0,0);
	"####" A 0 A_FireProjectile("MT_105mmU_APFSDSshell_Dummy",0,1); 
	Goto MuzzleFlash_Default;

//Multi Purpose High Explosive  
MPHE2_Fire:
	"####" A 0 A_FireProjectile("MT_105mmMPHErocket_2",0,1,0,0,0);
	Goto MuzzleFlash_Rocket;
  
MPHE3_Fire:
	"####" A 0 A_FireProjectile("MT_105mmMPHErocket_3",0,1,0,0,0);
	Goto MuzzleFlash_Rocket;

//Bee Nest 
Bee2_FireA:
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, +0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, 0);
	Goto Bee_FireB;

Bee2_FireB:
	"####" A 0 A_JumpIf(CountInv("MT_105mmBeeHiveCount0_ZS") >= 2, "Clear");
	"####" A 0 A_GiveInventory("MT_105mmBeeHiveCount0_ZS", 1);
	
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, +0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.14 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, 0);

	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.14 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, 0);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, +0.1);
	loop;

Bee3_FireA:
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, +0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", 0, 0, 0, 0, BEE_PROJFLAG, 0);
	Goto Bee_FireB;

Bee3_FireB:
	"####" A 0 A_JumpIf(CountInv("MT_105mmBeeHiveCount0_ZS") >= 2, "Clear");
	"####" A 0 A_GiveInventory("MT_105mmBeeHiveCount0_ZS", 1);
	
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, +0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", +0.14 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, 0);

	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.14 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, 0);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, -0.1);
	"####" A 0 A_FireProjectile("MT_105mmBeeProjectile", -0.10 * CountInv("MT_105mmBeeHiveCount0_ZS"), 0, 0, 0, BEE_PROJFLAG, +0.1);
	loop;
 
//Chemical Explosive
Chemi2_Fire:
	"####" A 0 A_FireProjectile("MT_105mmChemshell_2",0,1,0,0,0);
	Goto MuzzleFlash_Default;

Chemi3_Fire:
	"####" A 0 A_FireProjectile("MT_105mmChemshell_3",0,1,0,0,0);
	Goto MuzzleFlash_Default;
  
////-------------
//CLEAR SPECIALS
////-------------
Clear:
	"####" A 0 A_TakeInventory("MT_105mmBeeHiveCount0_ZS", 999);
	Goto MuzzleFlash_Default;
}}