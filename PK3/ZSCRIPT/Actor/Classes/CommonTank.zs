//const int vehicle_Angle0 = 256;
//const int vehicle_Angle1 = 360;
//const int vehicle_Angle2 = 128;


//------------------------------------------------------------------------------
//CRASHES
//------------------------------------------------------------------------------
Class CrashTankIntotheGround1 : Actor
{
Default
{
    SeeSound "none";
    DeathSound "none";
    Decal "None";
	Damagetype "Stomp";
    Gravity 1.0;
	+FORCERADIUSDMG;
    Speed 1;
}
	States
    {
    Spawn:
        TNT1 A 0;
        Goto Death;
    Death:
        TNT1 A 0;
        TNT1 A 0; //A_Explode(5000, 130, 0);
		TNT1 A 1;
        Stop;
    }
}

Class CrashTankIntotheGround2 : CrashTankIntotheGround1
{
Default
{
	Damagetype "Kick";
}
    States
    {
    Spawn:
        TNT1 A 0;
        Goto Death;
    Death:
        TNT1 A 0;
        TNT1 A 0; //A_Explode(30, 220, 0);
		TNT1 A 1;
        Stop;
    }
}

//------------------------------------------------------------------------------
//TOKENS AND PITCH POINTS
//------------------------------------------------------------------------------
Class MT_PitchFrontToken : Inventory
{
Default
{
Inventory.Amount 1;
Inventory.MaxAmount 16;
}
}

Class MT_PitchRearToken : MT_PitchFrontToken {}

Class MT_PitchToRear : Inventory
{
Default
{
Inventory.Amount 1;
Inventory.MaxAmount 1;
}
}

Class MT_PitchReset : MT_PitchToRear {}

Class MT_CBoxPitchFront : Actor
{
Default
{
PROJECTILE;
+MISSILE;
+THRUSPECIES;
+DONTSPLASH;
-EXPLODEONWATER;
Radius 10;
Height 5;
Speed 0;
Scale 0.5;
Renderstyle "Add";
Species "TankPlayer";
}
States
{
Spawn:
	TNT1 A 0;
	TNT1 A 0 A_GiveToTarget("MT_PitchFrontToken");
	//TNT1 A 0 A_RadiusGive("MT_PitchFrontToken", 8, RGF_PLAYERS);
	SPRA C 1;
	Stop;
Death:
	SPRA A 2;
	Stop;
}}

Class MT_CBoxPitchRear : MT_CBoxPitchFront
{
Default
{
}
States
{
Spawn:
	TNT1 A 0;
	TNT1 A 0 A_GiveToTarget("MT_PitchRearToken");
	//TNT1 A 0 A_RadiusGive("MT_PitchRearToken", 8, RGF_PLAYERS);
	SPRA C 1;
	Stop;
Death:
	SPRA A 2;
	Stop;
}}


Class CheckPitchCenter : MT_CBoxPitchFront
{
Default
{
Radius 28;
Height 2;
Scale 0.4;
}
States
{
Spawn:
	TNT1 A 0 A_GiveToTarget("MT_PitchToRear");
	X055 C 2;
	Stop;
Death:
	TNT1 A 0 A_GiveToTarget("MT_PitchReset");
	EBAR A 2;
	Stop;
}}

Class CheckPitchRunOver : CheckPitchCenter
{
Default
{
Speed 50;
}
States
	{
Spawn:
	TNT1 A 1;
	Stop;
Death:
	TNT1 A 0;
	Stop;
Xdeath:
	TNT1 A 0 A_GiveToTarget("MT_PitchRearToken", 6);
	Stop;
	}
}


Class MT_Trig : Actor
{
Default
{
PROJECTILE;
+MISSILE;
+THRUSPECIES;
+DONTSPLASH;
-EXPLODEONWATER;
Radius 5;
Height 5;
Speed 0;
Scale 0.25;
Renderstyle "Add";
Species "TankPlayer";
}
States
{
Spawn:
	TNT1 A 0;
	TNT1 A 0 A_GiveToTarget("MT_PitchFrontToken");
	Stop;
Death:
	SPRA A 2;
	Stop;
}}


Class MT_Trig_B0 : MT_Trig
{
States
{
Spawn:
	TNT1 A 0;
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 1, floorz);
Death:
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 1, floorz);
	SPRA C 2;
	Stop;
}}

Class MT_Trig_B1 : MT_Trig
{
States
{
Spawn:
	TNT1 A 0;
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 2, floorz);
Death:
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 2, floorz);
	SPRA C 2;
	Stop;
}}


Class MT_Trig_A0 : MT_Trig
{
States
{
Spawn:
	TNT1 A 0;
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 3, floorz);
Death:
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 3, floorz);
	SPRA D 2;
	Stop;
}}

Class MT_Trig_A1 : MT_Trig
{
States
{
Spawn:
	TNT1 A 0;
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 4, floorz);
Death:
	TNT1 A 0 ACS_NamedExecuteWithResult("MT_Set_Vertex_Height", 4, floorz);
	SPRA D 2;
	Stop;
}}


//------------------------------------------------------------------------------
//TURRET
//------------------------------------------------------------------------------
Class MT_ChassisBase : Actor
{
int user_chassisangle;
int user_chassispitch;
int user_chassispitch_old; 
int user_pitch;
double vertex_B0, vertex_B1, vertex_A0, vertex_A1;
double deltapitch_front, deltapitch_rear, deltapitch;
const chassis_spawnflag = SXF_ABSOLUTEVELOCITY | SXF_ABSOLUTEANGLE;
const chassis_warpflag = WARPF_ABSOLUTEANGLE;
Default
{
+THRUACTORS;
+NOTIMEFREEZE;
+FLOORCLIP;
+NOGRAVITY;
+FIXMAPTHINGPOS;
+DONTINTERPOLATE;
-FLOORCLIP;
-FLOAT;
Mass 99999;
Radius 0;
Height 0;
Gravity 0;
}
States
{
Spawn:
TNK1 A 1;
TNK1 B 1;
TNK1 C 1;
Stop;
}


/*
static object Get_Self()
{
	return self;
}
*/

double MFunc_ResetPitch(double pitch = 0)
{
	double old_pitch = pitch;
		
    old_pitch = pitch;

    if (pitch != 0)
        {old_pitch = old_pitch - (pitch * 2);}
     
    return old_pitch;
}

void MFunc_VertexPitcher()
{
	//FRONT
	A_SpawnItemEx("MT_Trig_B0", 16, 14, 1);
	A_SpawnItemEx("MT_Trig_B1", 16, -14, 1);
	//REAR
	A_SpawnItemEx("MT_Trig_A0", -16, 14, 1);
	A_SpawnItemEx("MT_Trig_A1", -16, -14, 1);
}

double MFunc_CalcPitch(double A = 1)
{
	double new_pitch = 0;
	
	new_pitch = atan(A);
	
	return new_pitch;
}

}

Class MT_Tank_Chassis : MT_ChassisBase
{

static void Set_ChassisAngle(actor mo, int angle)
{
	let chassis = MT_Tank_Chassis(mo);

	if (chassis != null)
	{

		CallACS("MT_SetVehicleRotation", angle);
		chassis.user_chassisangle = angle;

		//Console.PrintF("angle %d user %d", angle, chassis.user_chassisangle);
		chassis.SetStateLabel("GetRotation", false);
	}
}

	//Function for switching model
	Static void SwitchModel(actor mo)
	{
		/*
		if (mo.CheckInventory("MT_Tiger1", 1, AAPTR_TARGET))
		{ 
			mo.SetStateLabel("Tiger1"); 
		}
		*/
		
		mo.SetStateLabel("Tiger1"); 
	}

	//Execute functions
	Static void CallFunctions(actor Player)
	{
		SwitchModel(Player);
	}


	States
	{		
	GetRotation:
		"####" A 0 
		{
			user_chassisangle = user_chassisangle;
			A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, user_chassispitch);		
		}
		Goto Stay;
	
	
	Spawn:
		LEO1 A 0;
		LEO1 A 0 
		{
			user_chassisangle = 0;
			user_chassispitch = 0;
			user_pitch = 0;
			user_chassisangle = CallACS("MT_GetVehicleRotation");
			//Send its variable to the Eventhandler of Class Switcher
			ClassSwitcher.Send_Actor(self, self, "chassis");
			SwitchModel(invoker);
			
		}
		LEO1 A 1;
		Goto Spawn2;

	Spawn2:
		LEO1 A 1 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, "Stay");
		Goto Stay;
	
	DeMorph:
		"####" "#" 0 
		{
			SwitchModel(invoker);
		}
		Goto Stay;
		
	Stay:
		"####" "#" 0 A_JumpIfInventory("MT_MorphVCrewToken", 1, "Blank", AAPTR_TARGET);
		//PITCH CHECK
		"####" "#" 0
		{		
			/*
			MFunc_VertexPitcher();
			vertex_B0 = CallACS("MT_Get_Vertex_Height", 1) - CallACS("MT_ReturnHeight", 44440);
			vertex_B1 = CallACS("MT_Get_Vertex_Height", 2) - CallACS("MT_ReturnHeight", 44440);
			vertex_A0 = CallACS("MT_Get_Vertex_Height", 3) - CallACS("MT_ReturnHeight", 44440);
			vertex_A1 = CallACS("MT_Get_Vertex_Height", 4) - CallACS("MT_ReturnHeight", 44440);
			deltapitch_front = deltaangle(vertex_B0, vertex_B1);
			deltapitch_rear = deltaangle(vertex_A0, vertex_A1);
			deltapitch = deltaangle(deltapitch_front, deltapitch_rear);
			
			//user_chassispitch = deltapitch_rear - deltapitch_front;
			
			//A_LogFloat(CallACS("MT_ReturnHeight", 44440));
			A_LogFloat(deltapitch_front);
			A_LogFloat(deltapitch_rear);
			//A_LogFloat(user_chassispitch);
			*/
			
			if (user_chassispitch > 0)
			{
				user_chassisangle = CallACS("MT_GetVehicleRotation");
				A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, MFunc_ResetPitch(pitch));
				A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, user_chassispitch);		
			}
			else if (user_chassispitch < 0)
			{
				user_chassisangle = CallACS("MT_GetVehicleRotation");
				A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, MFunc_ResetPitch(pitch));
				A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, -user_chassispitch);		
			}
			else if (user_chassispitch == 0)
			{
				user_chassisangle = CallACS("MT_GetVehicleRotation");
				A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, MFunc_ResetPitch(pitch));
			}
						
			
			
		}		
		//END PITCH CHECK
	Movement:
		"####" "#" 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" "#" 0 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag);
		"####" "#" 0 A_JumpIfInventory("Reverse", 1, "MoveB1", AAPTR_TARGET);
		"####" "#" 0 A_JumpIfInventory("Accelerate", 1, "MoveF1", AAPTR_TARGET);
		"####" "#" 0 A_JumpIfInventory("TurnLeft", 1, "MoveF1", AAPTR_TARGET);
		"####" "#" 0 A_JumpIfInventory("TurnRight", 1, "MoveF1", AAPTR_TARGET);
		"####" "#" 1;
		Goto ItemClear;
		
		
	//PITCH UP
	PitchFront:
		"####" "#" 0 A_JumpIfInventory("MT_PitchReset", 1, "PitchClear");
		"####" "#" 0 A_JumpIfInventory("MT_PitchToRear", 3, "PitchRear");
		//"####" "#" 0 A_Log("FRONT");
		"####" "#" 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" "#" 0 {user_chassispitch = -user_pitch * countinv("MT_PitchRearToken");}
		"####" "#" 0 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, MFunc_ResetPitch(pitch));
		"####" "#" 0 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, user_chassispitch);
		"####" "#" 1;
		Goto ItemClear;

	//PITCH DOWN
	PitchRear:
		"####" "#" 0 A_JumpIfInventory("MT_PitchReset", 1, "PitchClear");
		//"####" "#" 0 A_Log("REAR");
		"####" "#" 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" "#" 0 {user_chassispitch = user_pitch * countinv("MT_PitchFrontToken");}
		"####" "#" 0 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, MFunc_ResetPitch(pitch));
		"####" "#" 0 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, -user_chassispitch);
		"####" "#" 1;
		Goto ItemClear;

	//PITCH CLEAR		
	PitchClear:
		"####" "#" 0 {
			//A_Log("CLEAR");
			user_chassisangle = CallACS("MT_GetVehicleRotation");
			user_chassispitch_old = MFunc_ResetPitch(pitch);
			A_TakeInventory("MT_PitchToRear", 999);
			A_TakeInventory("MT_PitchReset", 999);
			A_TakeInventory("MT_PitchRearToken", 999);
			A_TakeInventory("MT_PitchFrontToken", 999);
		}
		"####" "#" 0 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, MFunc_ResetPitch(pitch));
		Goto Movement;
	
	ItemClear:
		"####" "#" 0 {
			user_chassisangle = CallACS("MT_GetVehicleRotation");
			user_chassispitch_old = user_chassispitch; 
			user_chassispitch = 0;
			A_TakeInventory("MT_PitchToRear", 999);
			A_TakeInventory("MT_PitchReset", 999);
			A_TakeInventory("MT_PitchRearToken", 999);
			A_TakeInventory("MT_PitchFrontToken", 999);
		}
		"####" "#" 0 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag, null, 0, 0, user_chassispitch);
		Goto Stay;
	
	//FORWARD
	MoveF1:
		"####" B 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" B 1 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag);
	MoveF2:
		"####" C 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" C 1 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag);
	MoveF3:
		"####" D 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" D 1 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag);
		Goto Stay;
		
	//BACKWARD
	MoveB1:
		"####" D 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" D 1 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag);
	MoveB2:
		"####" C 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" C 1 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag);
	MoveB3:
		"####" B 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" B 1 A_Warp(AAPTR_TARGET, 0, 0, 0, user_chassisangle, chassis_warpflag);
		Goto Stay;
		
	//TURN LEFT

	//TURN RIGHT

	Blank:
		TNT1 A 1;
		TNT1 A 0 A_JumpIf(CountInv("MT_MorphVCrewToken") == 0, "DeMorph");
		loop;
		
	//Available Models
	//Leopard 1
	Leopard1:
		LEO1 A 0;
		Goto Stay;
	//Tiger 1
	Tiger1:
		TIG1 A 0;
		Goto Stay;	
	//Panzer III Ausf J
	PanzerIIIJ:
		PZJ3 A 0;
		Goto Stay;
	
		
	}	
}


Class MT_BaseTank : PlayerPawn
{
const chassis_spawnflag = SXF_ABSOLUTEVELOCITY + SXF_ABSOLUTEANGLE + SXF_TRANSFERPITCH;
const t_turnrate = 45; //tics turnrate
const t_turnrate_move = 50; //tics turn rate + accel
const turnrate = 4; 
const turnrate_move = 3;
const accelerate = 1;
const reverse = 1;
int user_chassisangle;
//Actor p_chassis;

	//Corrects the chassis angle when it gets teleported.
	override void PostTeleport(Vector3 destpos, double destangle, int flags)
	{

		Super.PostTeleport(destpos, destangle, flags);
	
		let p_chassis = ClassSwitcher.Get_Chassis();
		if (p_chassis)
		{
			let	Chassis_Base = MT_Tank_Chassis(p_chassis);
			
			Chassis_Base.Set_ChassisAngle(p_chassis, destangle - 180);
		}
	}

	//Function for switching model
	Static void SwitchModel(actor Player)
	{
		/*
		if (player.CheckInventory("MT_Tiger1", 1, AAPTR_DEFAULT))
		{ 
			player.SetStateLabel("MT_Tiger1", true); 
		}
		*/
		
		player.SetStateLabel("Tiger1", true); 
	}
	
	//Function to force switch weapon
	Static void Call_SelectWeapon(actor Player, string Wepon)
	{
		player.A_SelectWeapon(wepon);
	}
	
	
Default
{
player.DisplayName "BASE TANK";
player.viewheight 25;
player.attackzoffset 13;
player.forwardmove 0.0;
player.sidemove 0;
player.jumpz 0;
player.face "TKF";
player.maxhealth 1600;
Player.DamageScreenColor "Black", 0.05;
health 1600;
Speed 0.0;
Species "TankPlayer";
Player.SoundClass "mt_vehicle";
MaxStepHeight 24;
Radius 16;
Height 20;
Mass 50000;
PainChance 128;
BloodType "TankBlood", "TankBlood", "TankBlood";
-FLOORCLIP;
+FIXMAPTHINGPOS;
+DONTRIP;
Player.ColorRange 112, 127;
//Internal stuff, very important
/*
Player.StartItem "MT_PitchToRear", 1;
Player.StartItem "MT_PitchReset", 1;
Player.StartItem "MT_PitchRearToken",1;
Player.StartItem "MT_PitchFrontToken",1;
Player.StartItem "MT_Tiger1", 1;
Player.StartItem "TurnLeft", 1;
Player.StartItem "TurnRight", 1;
Player.StartItem "ImCrafting", 1;
*/

Player.StartItem "MT_ClassToken"              ,1;
Player.StartItem "MTU_SupplyBox_2"            ,1;
Player.StartItem "MT_Subgun_Slot"             ,1;
Player.StartItem "MT_AmmoSwitcher"            ,1;
Player.StartItem "MT_AmmoSwitcher_Reverse"    ,1;
Player.StartItem "MT_SubgunSwitcher"          ,1;
Player.Startitem "MT_SubgunSwitcher_Reverse"  ,1;
Player.Startitem "MT_Searchlight"             ,1;
Player.StartItem "MT_Nightvision_MK1"         ,1;
Player.StartItem "MT_ChaseCamera_MK1"         ,1;
Player.StartItem "MT_ChaseCameraToken"        ,2;
Player.StartItem "MT_PeriscopeItem"           ,1;
Player.StartItem "MT_Classmenu_Item"          ,1;
//Lockers
//Weapons
Player.StartItem "Multi_Purpose_Device"       ,1;
//Ammo
Player.Startitem "MT_75x500mmHE"                ,30;
Player.Startitem "MT_75x500mmAP"                ,60;
Player.Startitem "A_7u62x54mmR"                 ,2000;
//Items
//  Player.startitem "Item_GrenadePod_Smoke"        ,8
Player.startitem "Item_GrenadePod_SSS"          ,1;
Player.startitem "MT_Item_GrenadePod_Flare"     ,40;
Player.Startitem "MT_GrenadePod_Explosive"      ,20;
  
//MT Damage types
DamageFactor "PiercingExplosive" ,0.75;
DamageFactor "Piercing"          ,0.8;
DamageFactor "Frag"              ,0.05;
DamageFactor "Bullet"            ,0.15;
DamageFactor "Acid"              ,0.5;
DamageFactor "Chemical"          ,0.5;
DamageFactor "Build"             ,0;
//Other Damage types
DamageFactor "Normal"            ,0.8;
DamageFactor "Extreme"           ,0.8;
DamageFactor "Drowning"          ,0.0;
DamageFactor "Falling"           ,0.1;
DamageFactor "Ice"               ,0.2;
DamageFactor "Fire"              ,0.1;
Damagefactor "stomp"             ,0;
DamageFactor "Energy"            ,0.85;
DamageFactor "Radiation"         ,0.0;
DamageFactor "Nuclear"           ,0.9;
DamageFactor "Explosive"         ,0.25;
DamageFactor "Buckshot"          ,0;
DamageFactor "Reclaim"           ,0.9;
DamageFactor "Poison"            ,0;
DamageFactor "PoisonCloud"       ,0;
DamageFactor "Electric"          ,0.75;
}
	States
	{
	Pain:
		"####" A 0;
		"####" A 1 A_Pain;
		Goto CheckIfStillMoves;

	Blank:
		TNT1 A 0;
		Goto Stay;

	//
	//INITALIZATION
	//
	Spawn:
		TNK1 A 0 NoDelay;
		TNK1 A 0
		{
			cvar tankcv;

			if (!tankcv)
			{
				//Get Chassis CVAR
				tankcv = CVAR.GetCVAR("mtccvar_player_class");
			}
			if (tankcv)
			{
				GiveInventory(tankcv.GetString(), 1);
				WeaponClass.ChangeWeapons(Self, tankcv.GetString());
			}
		
			ThrustThingZ(0, 100, -1, 1);
			A_PlaySound("TankEngine/Start", 0, 0.8, 0, ATTN_IDLE);

			ClassSwitcher.Send_Actor(self, self, "turret");
			SwitchModel(Self);
			
			A_SpawnItemEx("MT_Tank_Chassis", 0, 0, 0, 0, 0, 0, user_chassisangle, chassis_spawnflag);			
			
			CallACS("MT_ChangeTid", 0, 44440);
		}
		TNK1 A 1;
	Spawn2:
		TNK1 A 0;
		Goto Stay;
	
	DoNothing:
		"####" A 1;
		Goto Stay;
		
	//
	//DRIVE
	//
	CheckIfStillMoves:
		"####" A 0;
		"####" A 0 A_JumpIfInventory("ImCrafting", 1, "DoNothing");
		"####" A 0 A_JumpIfInventory("Accelerate", 1, "Accelerate");
		"####" A 0 A_JumpIfInventory("Reverse", 1, "Reverse");
		"####" A 0 A_JumpIfInventory("TurnLeft", 1, "TurnLeft");
		"####" A 0 A_JumpIfInventory("TurnRight", 1, "TurnRight");
		"####" AAA 1;
		"####" A 0 A_StopSound(4);
		"####" A 0 A_PlaySound("Treads/Mid", 4);
		Goto Stay;	

	CheckIfStillMoves2:
		"####" A 0;
		"####" A 0 A_JumpIfInventory("ImCrafting", 1, "DoNothing");
		"####" A 0 A_JumpIfInventory("Accelerate", 1, "Accelerate");
		"####" A 0 A_JumpIfInventory("Reverse", 1, "Reverse");
		"####" A 0 A_JumpIfInventory("TurnLeft", 1, "TurnLeft");
		"####" A 0 A_JumpIfInventory("TurnRight", 1, "TurnRight");
		"####" AAA 1;
		"####" A 0 A_StopSound(4);
		"####" A 0 A_PlaySound("Treads/Left", 4);
		Goto Stay;	
	
	Stay:
		"####" A 0 A_JumpIfInventory("Reverse", 1, "Reverse");
		"####" A 0 A_JumpIfInventory("Accelerate", 1, "Accelerate");
		"####" A 0 A_JumpIfInventory("TurnLeft", 1, "TurnLeft");
		"####" A 0 A_JumpIfInventory("TurnRight", 1, "TurnRight");
		"####" A 1;
		Goto Stay;
		
	Accelerate:
		"####" A 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" A 0 A_PlaySound("Treads/Forward", 4, 1, 1);
		"####" A 0 A_JumpIf(vel.z < 0, "Falling");
		"####" A 1;
		Goto CheckIfStillMoves;

	Reverse:
		"####" A 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" A 0 A_PlaySound("Treads/Backward", 4, 1, 1);
		"####" A 0 A_JumpIf(vel.z < 0, "Falling");
		"####" A 1;
		Goto CheckIfStillMoves;
		
	TurnRight:
		"####" A 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" A 0 A_PlaySound("Treads/Left", 4, 1, 1);
		"####" A 0 A_TakeInventory("TurnLeft", 999);
		"####" A 0 A_TakeInventory("TurnRight", 999);
		"####" A 0 A_JumpIf(vel.z < 0, "Falling");
		"####" A 1;	
		Goto CheckIfStillMoves2;

	TurnLeft:		
		"####" A 0 {user_chassisangle = CallACS("MT_GetVehicleRotation");}
		"####" A 0 A_PlaySound("Treads/Right", 4, 1, 1);
		"####" A 0 A_TakeInventory("TurnLeft", 999);
		"####" A 0 A_TakeInventory("TurnRight", 999);
		"####" A 0 A_JumpIf(vel.z < 0, "Falling");
		"####" A 1;
		Goto CheckIfStillMoves2;


	//
	//FALLING
	//			
	Falling:
		"####" A 0;
		"####" A 0 A_CheckFloor("CheckIfStillMoves");
	
	FallingForReal:
		"####" A 0;
		"####" A 1;
		"####" A 0 A_JumpIF(vel.z == 0, "CrashIntoGround");
		"####" A 0 A_GiveInventory("VehicleFallingCount", 1);
		Loop;
		
	CrashIntoGround:
		"####" A 0;
		"####" A 0 A_JumpIfinventory("VehicleFallingCount", 10, "CrashIntoGroundViolently");
		"####" A 1;
		"####" A 0 A_SpawnItem("CrashTankIntotheGround1");
		"####" A 0 A_SpawnItem("CrashTankIntotheGround2");
		"####" A 0; //A_SpawnItemEx ("LargeMassWaterImpact", 0, 0, -10)
		"####" A 0; //Radius_Quake(1, 6, 0, 4, 0)
		"####" A 0 A_PlaySound("V_LightCrash", 41);
		"####" A 0 A_TakeInventory("VehicleFallingCount", 9999);
		Goto Stay;
		
	CrashIntoGroundViolently:
		"####" A 0;
		"####" A 1;
		"####" A 0 A_SpawnItem("CrashTankIntotheGround1");
		"####" A 0 A_SpawnItem("CrashTankIntotheGround2");
		
		"####" A 0; //A_SpawnItemEx ("ExplosionSplashSpawner", 0, 0, -10)
		
		"####" A 0; //Radius_Quake(8, 24, 0, 4, 0)
		"####" A 0 A_PlaySound("V_LightCrash", 41);
		"####" A 0 A_PlaySound("V_MediumCrash", 42);
		"####" AAAA 0; //A_CustomMissile ("ExplosionSmoke", 0, 0, random (0, 360), 2, random (0, 360))
		"####" A 0 A_TakeInventory("VehicleFallingCount", 9999);
		"####" A 0 A_SetPitch(-8.0 + pitch);
		"####" A 1;
		"####" A 0 A_SetPitch(4.0 + pitch);
		"####" A 1;
		"####" A 0 A_SetPitch(4.0 + pitch);
		Goto Stay;		
	//
	//KILLED/DESTROYED
	//	
	Death:	
	XDeath:
		"####" A 1;
		"####" A 0; //A_SpawnItem("BigExplosion1112")
		"####" A 0 A_PlaySound("weapons/explode");
		"####" A 0 A_PlaySound("EXPLOSIO", 3);
		"####" A 0 A_Scream;
		"####" A 0 A_NoBlocking;
		"####" AAAAAA 0; // A_CustomMissile ("MetalTrashParticle1", 96, 0, random (0, 360), 2, random (0, 180))
		"####" AAAAAA 0; // A_CustomMissile ("MetalTrashParticle2", 96, 0, random (0, 360), 2, random (0, 180))
		"####" AAAAAAAAA 0; // A_CustomMissile ("GlassShard", 96, 0, random (0, 360), 2, random (0, 360))
		"####" A 0 A_Explode(100, 250);
		"####" A 5;
		"####" A 100;
		"####" A -1;
		Stop;

	//Available Models
	//Leopard 1
	Leopard1:
		LEO1 A 0;
		Goto Stay;
	//Tiger 1
	Tiger1:
		TIG1 A 0;
		Goto Stay;		
	//Panzer III Ausf J
	PanzerIIIJ:
		PZJ3 A 0;
		Goto Stay;		
	}	
	
}
//------------------------------------------------------------------------------
//CASEMATE
//------------------------------------------------------------------------------