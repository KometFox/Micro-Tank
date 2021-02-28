/*
TODO: Fix Deselect/Select animation
*/
//------------------------------------------------------------------------------
////Baseweapon
//------------------------------------------------------------------------------

//Subclasses for sending info to EventHandler renderoverlay
Mixin Class HUD_Ammo
{

	void Send_Info2HUD(string name_, TextureID ID, string AmmoItem)
	{
		HUD_AmmoDisplay.Set_AmmoName(name_);
		HUD_AmmoDisplay.Set_Sprite(ID);
		HUD_AmmoDisplay.Set_AmmoItem(AmmoItem);
	}	

}

Class MT_BaseweaponZS : MT_PlayerWeapon
{

	Static void Play_LoadingSound(Actor mo, string Sound_)
	{
		mo.A_PlaySound(Sound_, 3);
	}
	
	/*
	override state GetReadyState()
	{
		Super.GetReadyState();
		AmmoSwitcher.Set_Gun_Invoker(invoker);
		
		return FindState('Ready');
	}
	*/

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
	TNT1 A 0 
	{
		AmmoSwitcher.Set_Gun_Invoker(invoker);
	}
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
    "####" A 0 A_Playsound("LMachinegun/Fire", 55);
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
    "####" A 0 A_Playsound("HMachinegun/Fire", 55);
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




