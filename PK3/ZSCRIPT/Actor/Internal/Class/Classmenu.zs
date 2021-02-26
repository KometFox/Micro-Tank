//------------------------------------------------------------------------------
//CLASS SWITCHER
//------------------------------------------------------------------------------
Class ClassSwitcher : EventHandler
{
	int toggle; //Show Menu
	bool showpic; //Show Image
	TextureID Cursor, BlockTexture; //Cursor display
	SCursor MCursor; //Cursor position
	int Selected, Current_Selected; //Current Selection
	Menuoption SMenuOption[3]; //Menu positions
	S_MenuSize MenuSize[4]; //Maximum size of menu entries
	Classes SClasses[3][5]; //Classes
	Actor P_Chassis, P_Turret;
	//Constants
	//Array start
	const MEDIUMTANKS_S = 0;
	const HEAVYTANKS_S = 1;
	const MBTTANKS_S = 2;
	//Amount
	const MEDIUMTANKS = 4;
	const HEAVYTANKS = 2;
	const MBTTANKS = 1;

struct SCursor
{
	int row, column;
}

struct Classes
{
	TextureID Image;
	String Class_ID, Type, Name_;
}

struct Menuoption
{
	string Name_;
	int pos_x, pos_y;
}

struct S_Menusize
{
	int max_row, max_column;
}

enum E_Categories
{
	CATEGORY = 0,
	MEDIUM = 1,
	HEAVY = 2,
	MBT = 3,	
}


override void WorldLoaded(Worldevent e)
{
	Cursor = TexMan.CheckForTexture ("CURSO1", TexMan.Type_Any); 
	BlockTexture = TexMan.CheckForTexture ("BLOCK2", TexMan.Type_Any);
	Selected = CATEGORY;
	Current_Selected = CATEGORY;
	//CATEGORY
	MenuSize[0].max_row = 2;
	MenuSize[0].max_column = 0;
	//MEDIUM
	MenuSize[1].max_row = 0;
	MenuSize[1].max_column = MEDIUMTANKS -1;
	//HEAVY
	MenuSize[2].max_row = 0;
	MenuSize[2].max_column = HEAVYTANKS -1;
	//MBT
	MenuSize[3].max_row = 0;
	MenuSize[3].max_column = 0;

	//CATEGORIES
	SMenuOption[0].pos_x = 230;
	SMenuOption[0].pos_y = 100;
	SMenuOption[0].Name_ = "Medium"; 
	
	SMenuOption[1].pos_x = 310;
	SMenuOption[1].pos_y = 100;
	SMenuOption[1].Name_ = "Heavy"; 
	
	SMenuOption[2].pos_x = 390;
	SMenuOption[2].pos_y = 100;
	SMenuOption[2].Name_ = "MBT"; 

	
	//CLASSES
	//Medium
	SClasses[0][0].Image = TexMan.CheckForTexture ("TIGER1", TexMan.Type_Any); 
	SClasses[0][0].Class_ID = "MT_PanzerIIIJ";
	SClasses[0][0].Name_ = "Panzer III J";
	SClasses[0][0].Type = "Medium";

	SClasses[0][1].Image = TexMan.CheckForTexture ("TIGER1", TexMan.Type_Any); 
	SClasses[0][1].Class_ID = "MT_Tiger1";
	SClasses[0][1].Name_ = "Panzer IV";
	SClasses[0][1].Type = "Medium";

	SClasses[0][2].Image = TexMan.CheckForTexture ("TIGER1", TexMan.Type_Any); 
	SClasses[0][2].Class_ID = "MT_Tiger1";
	SClasses[0][2].Name_ = "Panther I";
	SClasses[0][2].Type = "Medium";

	SClasses[0][3].Image = TexMan.CheckForTexture ("TIGER1", TexMan.Type_Any); 
	SClasses[0][3].Class_ID = "MT_Tiger1";
	SClasses[0][3].Name_ = "Panther II";
	SClasses[0][3].Type = "Medium";

	//Heavy
	SClasses[1][0].Image = TexMan.CheckForTexture ("TIGER1", TexMan.Type_Any); 
	SClasses[1][0].Class_ID = "MT_Tiger1";
	SClasses[1][0].Name_ = "Tiger I";
	SClasses[1][0].Type = "Heavy";

	SClasses[1][1].Image = TexMan.CheckForTexture ("TIGER1", TexMan.Type_Any); 
	SClasses[1][1].Class_ID = "MT_Tiger1";
	SClasses[1][1].Name_ = "Tiger II";
	SClasses[1][1].Type = "Heavy";

	//MBT
	SClasses[2][0].Image = TexMan.CheckForTexture ("LEOPAR2", TexMan.Type_Any); 
	SClasses[2][0].Class_ID = "MT_Leopard1";
	SClasses[2][0].Name_ = "Leopard 1";
	SClasses[2][0].Type = "MBT";

}

static void Change_Class(actor player)
{
	ClassSwitcher CS;
	CS = ClassSwitcher(EventHandler.Find("ClassSwitcher"));
	WeaponClass WC;
	WC = WeaponClass(EventHandler.Find("WeaponClass"));

	for (int i = 0; i < 3; i++)
	{
		player.TakeInventory(CS.SClasses[i][0].Class_ID, 999);
	}
	
	player.GiveInventory(CS.SClasses[CS.MCursor.Row][CS.MCursor.Column].Class_ID, 1);
	//Tell the chassis and the player actor to switch its model.
	MT_Tank_Chassis.SwitchModel(CS.P_Chassis);
	MT_BaseTank.SwitchModel(CS.P_Turret);
	MT_PlayerClass_Tank.SwitchModel(CS.P_Turret);
	//Switch the weapons...
	WC.ChangeWeapons(player, CS.SClasses[CS.MCursor.Row][CS.MCursor.Column].Class_ID);
	

	//Debug
	//Console.PrintF("Class Selected: %s %s", CS.SClasses[CS.MCursor.Row][CS.MCursor.Column].Name_, CS.SClasses[CS.MCursor.Row][CS.MCursor.Column].Class_ID);
	
}

//Get actors from the chassis and the player class
static void Send_Actor(actor mo, actor mo2, string type)
{
	ClassSwitcher CS;
	CS = ClassSwitcher(EventHandler.Find("ClassSwitcher"));
	
	//chassis actor
	if (type == "chassis")
	{
		CS.P_Chassis = mo2;
	}
	//player class actor
	else if (type == "turret")
	{
		CS.P_Turret = mo2;
	}

	//Debug
	//Console.PrintF("A: %p B: %p", CS.P_Turret, CS.P_Chassis);	
}


int Cursor_Mover(string move_to, int max_row, int max_column)
{
	if (move_to == "RIGHT")
	{
		if (MCursor.row < max_row)
		{
			MCursor.row += 1;
		}	
	}
	else if (move_to == "LEFT")
	{
		if (MCursor.row > 0)
		{
			MCursor.row -= 1;
		}	
	}


	else if (move_to == "DOWN")
	{
		if (MCursor.column < max_column)
		{
			MCursor.column += 1;
		}
	}
	else if (move_to == "UP")
	{
		if (MCursor.column > 0)
		{
			MCursor.column -= 1;
		}	
	}


	return 0;
}


override void NetworkProcess(Consoleevent e)
{		
		int FO1, FO2;
		int BA1, BA2;
		int ML1, ML2;
		int MR1, MR2;
		int Con1, Con2;
		int array_x_limit, array_y_limit;
		[FO1, FO2] = Bindings.GetKeysForCommand("+forward");
		[BA1, BA2] = Bindings.GetKeysForCommand("+back");
		[ML1, ML2] = Bindings.GetKeysForCommand("+moveleft");
		[MR1, MR2] = Bindings.GetKeysForCommand("+moveright");
		[Con1, Con2] = Bindings.GetKeysForCommand("+use");


			//Do not listen for input if the menu is not open.
			if (showpic == true)
			{


			//Set the limit to prevent out of bound error
			if (Selected == CATEGORY && Current_Selected == CATEGORY)
			{
				array_x_limit = MenuSize[0].max_row;
				array_y_limit = MenuSize[0].max_column;
			}
			
			else if (Current_Selected == MEDIUM)
			{	
				array_x_limit = MenuSize[1].max_row;
				array_y_limit = MenuSize[1].max_column;
			}

			else if (Current_Selected == HEAVY)
			{
				array_x_limit = MenuSize[2].max_row;
				array_y_limit = MenuSize[2].max_column;
			}
			else if (Current_Selected == MBT)
			{
				array_x_limit = MenuSize[3].max_row;
				array_y_limit = MenuSize[3].max_column;
			}
			
			if (Current_Selected == CATEGORY)
			{
			
				if ((FO1 && FO1 == e.Args[0]) || (FO2 && FO2 == e.Args[0]))
				{
					Cursor_Mover("UP", array_x_limit, array_y_limit);
				}
				else if ((BA1 && BA1 == e.Args[0]) || (BA2 && BA2 == e.Args[0]))
				{
					Cursor_Mover("DOWN", array_x_limit, array_y_limit);
				}
				else if ((ML1 && ML1 == e.Args[0]) || (ML2 && ML2 == e.Args[0]))		
				{		
					Cursor_Mover("LEFT", array_x_limit, array_y_limit);
				}
				else if ((MR1 && MR1 == e.Args[0]) || (MR2 && MR2 == e.Args[0]))
				{
					Cursor_Mover("RIGHT", array_x_limit, array_y_limit);
				}
			
				else if ((CON1 && CON1 == e.Args[0]) || (CON2 && CON2 == e.Args[0]))
				{
	
					if (MCursor.column == 0)
					{
						if (MCursor.row == 0)
						{
							Current_Selected = MEDIUM;
						}
						else if (MCursor.row == 1)
						{
							Current_Selected = HEAVY;
						}
						else if (MCursor.row == 2)
						{
							Current_Selected = MBT;
						}				
					}
			
				}
			
			}
			
			//The chassis selection
			else if (Current_Selected != CATEGORY)
			{
			
				if ((FO1 && FO1 == e.Args[0]) || (FO2 && FO2 == e.Args[0]))
				{
					if (MCursor.column == 0)
					{
						Current_Selected = CATEGORY;
					}
					else
					{
						Cursor_Mover("UP", array_x_limit, array_y_limit);
					}
				}
				else if ((BA1 && BA1 == e.Args[0]) || (BA2 && BA2 == e.Args[0]))
				{
					Cursor_Mover("DOWN", array_x_limit, array_y_limit);
				}


				//Change the chassis
				else if ((CON1 && CON1 == e.Args[0]) || (CON2 && CON2 == e.Args[0]))
				{
					let playa = players[0].mo;

					if (playa != null)
					{
						Change_Class(playa);
					}	
		
				}
				
				/*
				else if ((ML1 && ML1 == e.Args[0]) || (ML2 && ML2 == e.Args[0]))
				{		
					Cursor_Mover("LEFT", array_x_limit, array_y_limit);
				}
				else if ((MR1 && MR1 == e.Args[0]) || (MR2 && MR2 == e.Args[0]))
				{
					Cursor_Mover("RIGHT", array_x_limit, array_y_limit);
				}
				*/			
			}
			
			//Console.PrintF("ROW: %d \n COLUMN: %d", MCursor.row, MCursor.column);
			
			}

}

	
// PLAY scope : collect data
override void WorldTick()	// PLAY scope
{

	if (toggle == 1)
	{
		showpic = true;
	}
	else
	{
		showpic = false;
		MCursor.row = 0;
		MCursor.column = 0;
	}

}

//UI Scope: you cannot alter data here
override void renderOverlay(RenderEvent e)	// UI scope
{	
			
	if (showpic)
	{	
	
		//Categories
		for (int i = 0; i < 3; i++)
		{
			if (MCursor.row != i)
			{
				Screen.DrawText(Confont, Font.CR_DARKGREEN, SMenuOption[i].pos_x, SMenuOption[i].pos_y, String.Format(" %s ", SMenuOption[i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);
			}
			else if (MCursor.row == i)
			{
				Screen.DrawText(Confont, Font.CR_GREEN, SMenuOption[i].pos_x, SMenuOption[i].pos_y, String.Format("[%s]", SMenuOption[i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);
			}	
		}
	
		
		if (Current_Selected == Medium)
		{
			for (int i = 0; i < MEDIUMTANKS; i++)
			{		
				if (MCursor.Column != i)
				{
					Screen.DrawText(Confont, Font.CR_DARKGREEN, 210, 130 + (20 * i), String.Format(" %s ", SClasses[MEDIUMTANKS_S][i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);
				}
				else if (MCursor.Column == i)
				{
					Screen.DrawText(Confont, Font.CR_GREEN, 210, 130 + (20 * i), String.Format("[%s]", SClasses[MEDIUMTANKS_S][i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);	
					Screen.DrawTexture(SClasses[MEDIUMTANKS_S][i].image, false, 400, 130, DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);				
				}			
			}		
		}
		
		if (Current_Selected == Heavy)
		{
			for (int i = 0; i < HEAVYTANKS; i++)
			{		
				if (MCursor.Column != i)
				{
					Screen.DrawText(Confont, Font.CR_DARKGREEN, 210, 130 + (20 * i), String.Format(" %s ", SClasses[HEAVYTANKS_S][i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);
				}
				else if (MCursor.Column == i)
				{
					Screen.DrawText(Confont, Font.CR_GREEN, 210, 130 + (20 * i), String.Format("[%s]", SClasses[HEAVYTANKS_S][i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);	
					Screen.DrawTexture(SClasses[HEAVYTANKS_S][i].image, false, 400, 130, DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);				
				}			
			}		
		}
		
		if (Current_Selected == MBT)
		{
			for (int i = 0; i < MBTTANKS; i++)
			{		
				if (MCursor.Column != i)
				{
					Screen.DrawText(Confont, Font.CR_DARKGREEN, 210, 130 + (20 * i), String.Format(" %s ", SClasses[MBTTANKS_S][i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);
				}
				else if (MCursor.Column == i)
				{
					Screen.DrawText(Confont, Font.CR_GREEN, 210, 130 + (20 * i), String.Format("[%s]", SClasses[MBTTANKS_S][i].Name_), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);	
					Screen.DrawTexture(SClasses[MBTTANKS_S][i].image, false, 400, 130, DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);				
				}			
			}		
		}
		
	
			
	}
}

static void CM_OpenMenu(actor player)
{
	ClassSwitcher Event;
	Event = ClassSwitcher(EventHandler.Find("ClassSwitcher"));
	/*
	if (player.CountInv("MT_Classmenu_Item") == 1)
	{
		Event.toggle = 0; 
		player.SetInventory("MT_Classmenu_Item", 2);
		player.TakeInventory("ImCrafting", 99);
	}
	else if (player.CountInv("MT_Classmenu_Item") == 2)	
	{
		Event.toggle = 1;
		player.SetInventory("MT_Classmenu_Item", 1);
		player.GiveInventory("ImCrafting", 99);
	}
	*/
	
	Switch (player.CountInv("MT_Classmenu_Item"))
	{
	case (1):
		Event.toggle = 0; 
		player.SetInventory("MT_Classmenu_Item", 2);
		player.TakeInventory("ImCrafting", 99);	
		Break;
	case (2):
		Event.toggle = 1;
		player.SetInventory("MT_Classmenu_Item", 1);
		player.GiveInventory("ImCrafting", 99);
		Break;
	}	

}



}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
Class MT_Classmenu_Item : MT_SPlayerCustomInventory
{

	Default
	{
		Inventory.Icon "FGRSB0";
		Inventory.PickupMessage "Picked up: Classmenu";
		Inventory.Amount 1;
		Inventory.MaxAmount 2;
		Inventory.InterHubAmount 2;
		Tag "Classmenu";	
	}

	States
	{

		Use:
			TNT1 A 0;
			TNT1 A 0
			{
				CallEm(self);
			}
			Fail;

	}

	static void CallEm(Actor self)
	{

		let handler = ClassSwitcher(EventHandler.Find('ClassSwitcher'));

		if (handler == null) {}	
		else
		{
			let playa = PlayerPawn(self);

			if (playa != null)
			{

				handler.CM_OpenMenu(playa);

			}
		}

	}

}


//------------------------------------------------------------------------------
//CLASS WEAPON TRANSFER
//------------------------------------------------------------------------------
Class WeaponTransfer : EventHandler
{
	S_Weapons Weapons[4][1];



Struct S_Weapons
{
	String WeaponID, Class_;
}

override void WorldLoaded(WorldEvent e)
{
	Weapons[0][0].WeaponID = "MT_50mmCannon";
	Weapons[0][0].Class_ = "Medium";
	
	Weapons[1][0].WeaponID = "MT_75mmCannon";
	Weapons[1][0].Class_ = "Advanced_Medium";
	
	Weapons[2][0].WeaponID = "MT_90mmCannon";
	Weapons[2][0].Class_ = "Heavy";
	
	Weapons[3][0].WeaponID = "MT_105mmCannon";
	Weapons[3][0].Class_ = "MBT";
}






}


