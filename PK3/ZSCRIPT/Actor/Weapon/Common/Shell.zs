/* Projectile Shell
 * Template to define new shell projectile
 * Mass and Velocity determines direct damage
 * ExplosiveMass determines splash damage
 */

Mixin Class Common_Proj
{
	int Dmg;
}

Mixin Class Base_Shell 
{
	//Projectile Property
	int Mass, Velocity, ExplosivMass;
	string ExplosiveType;
	//Damages
	int SplashDamage, SplashRadius, SplashFRadius;
	//Effects
	string ImpactEffect, SoftEffect, HardEffect;
	string Trail;
	
	//Projectile Property
	//Damage
	Property SplashDamage: SplashDamage;
	Property SplashRadius: SplashRadius;
	Property SplashFRadius: SplashFRadius;
	//Effect
	Property ImpactEffect: ImpactEffect;
	Property SoftEffect: SoftEffect;
	Property HardEffect: HardEffect;
	Property Trail: Trail;

	States
	{
		
		Spawn:
			PROJ A 0 NoDelay;
			PROJ A 0 
			{
				if (Trail)
				{
					Return A_Jump(256, "TrailOn");
				}
			
				Return A_Jump(0, "TrailOff");
			}
			Goto TrailOff;
		
		TrailOn:
			PROJ A 1 A_SpawnItemEx(Trail, 0, 0, 0);
			Loop;
			
		TrailOff:
			PROJ A 1;
			Loop;
		
		Crash:
			TNT1 A 0 A_SpawnItemEx(HardEffect, 0, 0, 0);
			Goto FinalDeath;
		XDeath:
			TNT1 A 0 A_SpawnItemEx(SoftEffect, 0, 0, 0);
			Goto FinalDeath;
		Death:
			TNT1 A 0 A_SpawnItemEx(ImpactEffect, 0, 0, 0);
			Goto FinalDeath;
		FinalDeath:
			TNT1 A 0 A_Explode(SplashDamage, SplashRadius, 0, False, SplashFRadius);
			TNT1 A 0 A_Scream();
			Stop;
	}
}

//Hit multiple targets.
Mixin Class MultiPiercing
{
	/*
	First get the victim health. If the victim health is greater
	than the current projectile damage then just do normal damage and
	kill the projectile, else kill the victim and proceed with normal
	trajectory.			
	*/
	
	//Requires Common_Proj to work!
	//Mixin Common_Proj;
	
	Override void BeginPlay()
	{
		Dmg = GetMissileDamage(0, 0, AAPTR_DEFAULT);
				
		Super.BeginPlay();
	}

	Override int SpecialMissileHit (Actor victim)
	{
		int Victim_HP = victim.health;
		
		if (!victim.player && Dmg > 0)
		{
			victim.DamageMobj(self, target, Dmg, damagetype, 0);
			Dmg -= Victim_HP;	
		}

		if (Dmg <= 0)
		{
			//Using -1 here results in double damage.
			return 0;
		}
		
		return 1;
	}


}


Class MT_Projectile : Actor
{
	Mixin Common_Proj;
	Mixin Base_Shell;

	Default
	{
		Radius 7;
		Height 7;
		Speed 60;
		//DamageType Normal;
		Projectile;
		-NOGRAVITY;
		+BLOODSPLATTER;
		//+EXTREMEDEATH;
		//+FORCEPAIN;
		gravity 0.018;
		DamageFactor (0);
		DeathSound "Weapon/37mmblas";
		Obituary "%k killed %o";
	}

}

Class MT_FastProjectile : FastProjectile
{
	Mixin Common_Proj;
	Mixin Base_Shell;

	Default
	{
		Radius 7;
		Height 7;
		Speed 60;
		//DamageType Normal;
		Projectile;
		+BLOODSPLATTER;
		//+EXTREMEDEATH;
		//+FORCEPAIN;
		DamageFactor (0);
		DeathSound "Weapon/37mmblas";
		Obituary "%k killed %o";
	}

}

