/*
"Stores" weapons and switches them accordingly to player class.
What a fucking pain in the ass to write this stupid script, what the fuck is 
wrong trying to iterate the stupid array, it is not working god damn piece of
shit.
*/
Class WeaponClass : EventHandler
{
	const CHASSIS_IDX = 3; //Available chassis
	const INDEX = 3;
	S_Classes Classes[3][3];
	S_Weapons Weapons[3][1];

Struct S_Classes
{
	string Class_, Type;
}

Struct S_Weapons
{
	String WeaponID;
}


override void WorldLoaded(WorldEvent e)
{
	Classes[0][0].Type = "MBT";
	Classes[0][0].Class_ = "MT_Leopard1";
	
	Classes[1][0].Type = "Heavy";
	Classes[1][0].Class_ = "MT_Tiger1";
	
	Classes[2][0].Type = "Medium";
	Classes[2][0].Class_ = "MT_PanzerIIIJ";


	//MBT
	Weapons[0][0].WeaponID = "MT_50mmCannon";
	
	//Heavy
	Weapons[1][0].WeaponID = "MT_50mmCannon";
	
	//Medium
	Weapons[2][0].WeaponID = "MT_50mmCannon";

}

int CheckClass(string class_)
{
	for (int i0 = 0; i0 < 3; i0++)
	{
		for (int i1 = 0; i1 < 1; i1++)
		{
			if (Classes[i0][i1].Class_ == class_)
				return i0;			
		}	
	}
	
	return 0;
}

//
// TODO: Add support for bought weapons
//
//
//
Static void ChangeWeapons(actor Player, string cur_class)
{
	WeaponClass WC;
	WC = WeaponClass(EventHandler.Find("WeaponClass"));
	string type;
	int sel_class;
	
	//Console.PrintF("%d", WC.CheckClass(cur_class));
	sel_class = WC.CheckClass(cur_class);
	
	//Get rid of all the previous class weapon
	for (int i0 = 0; i0 < 3; i0++)
	{
		for (int i1 = 0; i1 < 1; i1++)
		{
			player.TakeInventory(WC.Weapons[i0][i1].WeaponID, 99);
		}
	}
	
	//Give the new class weapon
	player.GiveInventory(WC.Weapons[sel_class][0].WeaponID, 1);	
	//Force switch the weapon
	MT_BaseTank.Call_SelectWeapon(player, WC.Weapons[sel_class][0].WeaponID);
	
}


//Initial startup
void Change_Class()
{
	let player = players[0].mo;
	/*
	if (player)
	{
		player.GiveInventory(CVar.GetCVar("mtccvar_player_class").GetString(), 1);	
	}
	*/
	//CVar mofug = CVAR.GetCVar('mtccvar_player_class');
	//Console.PrintF("%s", mofug.GetString());
}





}