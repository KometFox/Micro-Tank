/*
 * This is probably a stupid way to do this but I cannot find a better method. 
 */
 
Class LoadingTimer : EventHandler
{
	const Items = 2;	
	S_Timers TimerList[2];

struct S_Timers
{
	string Item, Weapon_, LoadedSound;
	int duration;

}
	
override void WorldLoaded(WorldEvent e)
{
	//90mm Cannon
	TimerList[0].Item = "MT_90mmCannon_Timer1";
	TimerList[0].duration = 120;
	TimerList[0].Weapon_ = "MT_90mmCannon";
	TimerList[0].LoadedSound = "H_Cannon/Loaded";
	//50mm KwK
	TimerList[1].Item = "MT_50mmCannon_Timer1";
	TimerList[1].duration = 95;
	TimerList[1].Weapon_ = "MT_50mmCannon";
	TimerList[1].LoadedSound = "H_Cannon/Loaded";

}

override void WorldTick()
{
	Super.WorldTick();

	let player = players[0].mo;
	
	if (player)
	{
		Reload_Weapon(player);
	}	
}


Static void Reload_Weapon(actor player)
{
	LoadingTimer LT;
	LT = LoadingTimer(EventHandler.Find("LoadingTimer"));
	int timer;


	if (player.CountInv("MT_Timer") == 0)
	{
		for (int i = 0; i < LT.Items; i++)
		{

			if (player.CountInv(LT.TimerList[i].item) && player.CountInv(LT.TimerList[i].Item) != LT.TimerList[i].duration)
			{
				player.GiveInventory(LT.TimerList[i].item, 1);
			}
			else if (player.CountInv(LT.TimerList[i].Item) == LT.TimerList[i].duration)
			{
				player.TakeInventory(LT.TimerList[i].item, 9999);
				//player.GiveInventory("75mmReloaded", 1);
				MT_BaseweaponZS.Play_LoadingSound(player, LT.TimerList[i].LoadedSound);
			}
			
		}	
	}	
}


}


Class MT_Timer : Inventory
{
Default
{
-COUNTITEM;
Inventory.Amount 1;
Inventory.MaxAmount 1;
Inventory.InterHubAmount 1;
}
States
{
	Held:
		TNT1 A 1;
		Stop;
}

}

