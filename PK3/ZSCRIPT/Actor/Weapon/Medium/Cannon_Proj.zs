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

Class MT_50mmAPHE_Shell : MT_Projectile
{
	
	Default
	{
		DamageFunction (546);
		DeathSound "Medium/APExplosion";
		MT_Projectile.SplashDamage 80;
		MT_Projectile.SplashRadius 66;
		MT_Projectile.SplashFRadius 50;
		MT_Projectile.SoftEffect "MTCEG_MediumExplosion_APHE"; 
		MT_Projectile.HardEffect "MTCEG_MediumExplosion_APHE";
		MT_Projectile.ImpactEffect "MTCEG_MediumExplosion_APHE";
	}
}

Class MT_50mmAPCR_Shell : MT_Projectile
{
	Mixin MultiPiercing;

	Default
	{
		DamageFunction (790);
		DeathSound "Medium/APExplosion";
		MT_Projectile.SplashDamage 60;
		MT_Projectile.SplashRadius 30;
		MT_Projectile.SplashFRadius 15;	
		MT_Projectile.SoftEffect "MTCEG_MediumExplosion_APHE"; 
		MT_Projectile.HardEffect "MTCEG_MediumExplosion_APHE";
		MT_Projectile.ImpactEffect "MTCEG_MediumExplosion_APHE";
	}
}

Class MT_50mmHE_Shell : MT_Projectile
{

	Default
	{
		DamageFunction (42);
		DeathSound "Medium/Explosion";
		MT_Projectile.SplashDamage 499;
		MT_Projectile.SplashRadius 150;
		MT_Projectile.SplashFRadius 100;	
		MT_Projectile.SoftEffect "MTCEG_MediumExplosion_HEShell"; 
		MT_Projectile.HardEffect "MTCEG_MediumExplosion_HEShell";
		MT_Projectile.ImpactEffect "MTCEG_MediumExplosion_HEShell";
	}
}