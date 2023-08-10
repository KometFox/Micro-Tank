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
	Classes SClasses[1][1]; //Classes
	Actor P_Chassis, P_Turret;
	//Constants
	//Array start
	const MEDIUMTANKS_S = 0;
	//Amount
	const MEDIUMTANKS = 0;

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
}


override void WorldLoaded(Worldevent e)
{
	Cursor = TexMan.CheckForTexture ("CURSO1", TexMan.Type_Any); 
	BlockTexture = TexMan.CheckForTexture ("BLOCK2", TexMan.Type_Any);
	Selected = CATEGORY;
	Current_Selected = CATEGORY;
	//CATEGORY
	MenuSize[0].max_row = 1;
	MenuSize[0].max_column = 1;
	//MEDIUM
	MenuSize[1].max_row = 1;
	MenuSize[1].max_column = 1;

	//CATEGORIES
	SMenuOption[0].pos_x = 230;
	SMenuOption[0].pos_y = 100;
	SMenuOption[0].Name_ = "Medium";  

	
	//CLASSES
	//Medium
	SClasses[0][0].Image = TexMan.CheckForTexture ("TIGER1", TexMan.Type_Any); 
	SClasses[0][0].Class_ID = "MT_Tiger1";
	SClasses[0][0].Name_ = "Tiger 1";
	SClasses[0][0].Type = "Medium";
}

static void Change_Class(actor player)
{
	ClassSwitcher CS;
	CS = ClassSwitcher(EventHandler.Find("ClassSwitcher"));
	WeaponClass WC;
	WC = WeaponClass(EventHandler.Find("WeaponClass"));

	//player.GiveInventory("MT_Tiger1", 1);
	//player.GiveInventory("MT_105mmCannon", 1);
	//player.GiveInventory("MT_75mmCannon", 1);

	for (int i = 0; i < 1; i++)
	{
		if (player.Checkinventory(CS.SClasses[i][0].Class_ID, 1))
		{
			player.TakeInventory(CS.SClasses[i][0].Class_ID, 999);
		}
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

static actor Get_Chassis()
{
	ClassSwitcher CS;
	CS = ClassSwitcher(EventHandler.Find("ClassSwitcher"));
	
	return CS.P_Chassis;
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
		
		/*
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
		*/
		
	
			
	}
}

static void CM_OpenMenu(actor player)
{
	ClassSwitcher Event;
	Event = ClassSwitcher(EventHandler.Find("ClassSwitcher"));
	
	Switch (player.CountInv("MT_Classmenu_Item"))
	{
	case (1):
		Event.toggle = 0; 
		Event.showpic = false;
		Event.Mcursor.Row = 0;
		Event.MCursor.Column = 0;
		
		player.SetInventory("MT_Classmenu_Item", 0);
		if (player.CheckInventory("ImCrafting", 0))
			player.TakeInventory("ImCrafting", 99);	
		Break;
	case (2):
		Event.toggle = 1;
		Event.showpic = true;
		
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
	
	Weapons[1][0].WeaponID = "MT_50mmCannon";
	Weapons[1][0].Class_ = "Advanced_Medium";
	
	Weapons[2][0].WeaponID = "MT_50mmCannon";
	Weapons[2][0].Class_ = "Heavy";
	
	Weapons[3][0].WeaponID = "MT_50mmCannon";
	Weapons[3][0].Class_ = "MBT";
}






}


