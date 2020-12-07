//------------------------------------------------------------------------------
//Menu
//------------------------------------------------------------------------------

/*
Used for displaying menu and handling input.
*/

Class HPICube_Func : EventHandler
{
	TextureID Cursor, BlockLeft, BlockRight;
	bool showpic;
	int toggle, m_mode, c_mode, player_item_amount;
	SCursor MCursor;
	string category[3];
	MenuOptions MenuOption[4][3];
	const menu_limit = 2;
	const item_limit = 8;
	Menu_Modes menu_mode;
	Menu_Category menu_categories;

enum Menu_Modes
{
	menu = 0,
	item = 1,
}

enum Menu_Category
{
	Weapon = 0,
	Auxillary = 1,
	Upgrade = 2,
}

struct MenuMovement
{
	int row, columnn;
}

struct MenuOptions
{
	int pos_x, pos_y;
	int cursor_x, cursor_y;
	string command;
}

struct SCursor
{
	int position;
	int row, columnn;
}

override void WorldLoaded(WorldEvent e)
{
	Cursor = TexMan.CheckForTexture ("CURSOR", TexMan.Type_Any); 
	BlockLeft = TexMan.CheckForTexture ("BLOCKLE", TexMan.Type_Any);
	BlockRight = TexMan.CheckForTexture ("BLOCKRI", TexMan.Type_Any);

	category[0] = "Weapons";
	category[1] = "Auxillary";
	category[2] = "Upgrade";
	m_mode = menu;
	menu_mode = menu;
	
	MenuOption[0][0].pos_x = -75;
	MenuOption[0][0].pos_y = 20;
	MenuOption[0][0].cursor_x = 110;
	MenuOption[0][0].cursor_y = 35;
	MenuOption[0][0].command = category[0];
	
	MenuOption[0][1].pos_x = 30;
	MenuOption[0][1].pos_y = 20;
	MenuOption[0][1].cursor_x = 270;
	MenuOption[0][1].cursor_y = 35;
	MenuOption[0][1].command = category[1];
	
	MenuOption[0][2].pos_x = 150;
	MenuOption[0][2].pos_y = 20;
	MenuOption[0][2].cursor_x = 450;
	MenuOption[0][2].cursor_y = 35;
	MenuOption[0][2].command = category[2];


	MenuOption[1][0].pos_x = 280;
	MenuOption[1][0].pos_y = 100;
	MenuOption[1][0].cursor_x = 280;
	MenuOption[1][0].cursor_y = 100;
	MenuOption[1][0].command = "GO_LEFT";
	
	MenuOption[1][1].pos_x = 380;
	MenuOption[1][1].pos_y = 100;
	MenuOption[1][1].cursor_x = 380;
	MenuOption[1][1].cursor_y = 100;
	MenuOption[1][1].command = "GO_RIGHT";

	
	MenuOption[2][0].pos_x = 280;
	MenuOption[2][0].pos_y = 800;
	MenuOption[2][0].cursor_x = 280;
	MenuOption[2][0].cursor_y = 800;
	MenuOption[2][0].command = "GO_LEFT";
	
	MenuOption[2][1].pos_x = 380;
	MenuOption[2][1].pos_y = 800;
	MenuOption[2][1].cursor_x = 380;
	MenuOption[2][1].cursor_y = 800;
	MenuOption[2][1].command = "GO_RIGHT";

}

override bool InputProcess (InputEvent e)
{

	if (e.Type == InputEvent.Type_KeyDown)
	{
		SendNetworkEvent("TOGGLE_CRAFTMENU", e.KeyScan);
    }
	
	return false;	
}

//Limit where the cursor position can be.
bool Cursor_Movement(int current, int min, int max)
{

	if (current < max && current >= min)
	{
		console.printf("TRUE OUTPUT: %d %d", min, max);
		return True;
	} 
	else
	{
		console.printf("FALSE OUTPUT: %d %d", min, max);
		return False;
	}
}

//Set the cursor movement
void Cursor_Mover(string move) 
{
	HPICube_Func Cursor;
	Cursor = HPICube_Func(EventHandler.Find("HPICube_Func"));

	if (move == "UP")
	{
		Cursor.MCursor.columnn -= 1;
	}
	else if (move == "DOWN")
	{
		Cursor.MCursor.columnn += 1;
	}
	else if (move == "RIGHT" )
	{
		Cursor.MCursor.row += 1;
	}
	else if (move == "LEFT" )
	{
		Cursor.MCursor.row -= 1;
	}
	else if (move == "RESET_ROW")
	{
		Cursor.MCursor.row = 0;
	}
	else if (move == "RESET_COLUMNN")
	{
		Cursor.MCursor.columnn = 0;
	}
	else if (move == "RESET")
	{
		Cursor.MCursor.row = 0;
		Cursor.MCursor.columnn = 0;
	}
	
}



override void NetworkProcess(ConsoleEvent e)
{        
	HPICube_Func Event;
	HPICube_Items Items;
	Event = HPICube_Func(EventHandler.Find("HPICube_Func"));
	Items = HPICube_Items(EventHandler.Find("HPICube_Items"));
	int menu_selection;
	
	menu_selection = 0;
	
	string test = "";
	
	if (e.Name == "TOGGLE_CRAFTMENU")   
	{
		int FO1, FO2;
		int BA1, BA2;
		int ML1, ML2;
		int MR1, MR2;
		int Con1, Con2;
		int button_i0;
		[FO1, FO2] = Bindings.GetKeysForCommand("+forward");
		[BA1, BA2] = Bindings.GetKeysForCommand("+back");
		[ML1, ML2] = Bindings.GetKeysForCommand("+moveleft");
		[MR1, MR2] = Bindings.GetKeysForCommand("+moveright");
		[Con1, Con2] = Bindings.GetKeysForCommand("+use");

		if (Event.toggle == 1)
		{

//
//MENU MODE
//
	
			if (Event.m_mode == Event.menu)
			{
					
			if ((FO1 && FO1 == e.Args[0]) || (FO2 && FO2 == e.Args[0]))
			{	
				
				do
				{
					if (Event.MCursor.Columnn > 0)
					{
						Event.Cursor_Mover("UP");
					}
				}
				until (Event.MenuOption[Event.MCursor.Columnn][Event.MCursor.Row].command != "" && Event.MenuOption[Event.MCursor.Columnn][Event.MCursor.Row].command != "b" ); 

			}
			else if ((BA1 && BA1 == e.Args[0]) || (BA2 && BA2 == e.Args[0]))
			{	
							
				button_i0 = Event.MCursor.Columnn;
				
				while (button_i0 < menu_limit)
				{
					button_i0 += 1;
				

					if (Event.MCursor.Columnn == 1)
					{
						Event.m_mode = Event.item;
						Event.MCursor.Columnn = 0;
						Event.MCursor.Row = 0;
						break;
					}
					
					else if (Event.MenuOption[button_i0][Event.MCursor.Row].command != "" && Event.MenuOption[button_i0][Event.MCursor.Row].command != "b")
					{
						Event.MCursor.Columnn = button_i0;
						break;
					}					
					
					if (button_i0 >= menu_limit)
					{
						break;
					}					
				}				

			
			}
			else if ((ML1 && ML1 == e.Args[0]) || (ML2 && ML2 == e.Args[0]))
			{	
			
				if (Event.MCursor.Row > 0 && Event.MenuOption[Event.MCursor.Columnn][Event.MCursor.Row -1].command != "")
				{
					Event.Cursor_Mover("LEFT");
				}
				
			}
			else if ((MR1 && MR1 == e.Args[0]) || (MR2 && MR2 == e.Args[0]))
			{

				if (Event.MCursor.Row < menu_limit && Event.MenuOption[Event.MCursor.Columnn][Event.MCursor.Row +1].command != "")
				{
					Event.Cursor_Mover("RIGHT");
				}
				
			}	
			

			else if ((CON1 && CON1 == e.Args[0]) || (CON2 && CON2 == e.Args[0]))
			{

//
//SWITCH CATEGORIES
//			
				if(Event.MCursor.Columnn == 0 && Event.MCursor.Row == 0)
				{
					Event.c_mode = Event.Weapon;				
				}

				else if(Event.MCursor.Columnn == 0 && Event.MCursor.Row == 1)
				{
					Event.c_mode = Event.Auxillary;				
				}

				else if(Event.MCursor.Columnn == 0 && Event.MCursor.Row == 2)
				{
					Event.c_mode = Event.Upgrade;		
				}

//
//TURN PAGES
//
	
	
			}
			
			
			}
			
//
//ITEMS MODE
//
	
			else if (Event.m_mode == Event.item)
			{
				
			let handler = HPICube_Func(EventHandler.Find('HPICube_Func'));
			if (handler == null) {}
			
			let playa = players[0].mo;
				
			//Console.PrintF("ITEMS MODE");
					
			if ((FO1 && FO1 == e.Args[0]) || (FO2 && FO2 == e.Args[0]))
			{	
				
				do
				{
					if (Event.MCursor.Columnn == 0)
					{
						Event.MCursor.Columnn = 1;
						Event.MCursor.Row = 0;
						Event.m_mode = menu;						
					}
					
					else if (Event.MCursor.Columnn > 0)
					{
						Event.Cursor_Mover("UP");
					}
				}
				until (Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row].Items != ""); 

			}
			else if ((BA1 && BA1 == e.Args[0]) || (BA2 && BA2 == e.Args[0]))
			{	
							
				button_i0 = Event.MCursor.Columnn;
				
				while (button_i0 < item_limit)
				{
					button_i0 += 1;
				
					
					if (Items.Items[Event.c_mode][button_i0][Event.MCursor.Row].Items != "")
					{
						Event.MCursor.Columnn = button_i0;
						break;
					}
					
					
					if (button_i0 >= item_limit)
					{
						break;
					}					
				}				

			
			}
			else if ((ML1 && ML1 == e.Args[0]) || (ML2 && ML2 == e.Args[0]))
			{	
			
				if (Event.MCursor.Row > 0 && Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row -1].Items != "")
				{
					Event.Cursor_Mover("LEFT");
				}
				
			}
			else if ((MR1 && MR1 == e.Args[0]) || (MR2 && MR2 == e.Args[0]))
			{

				if (Event.MCursor.Row < item_limit && Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row +1].Items != "")
				{
					Event.Cursor_Mover("RIGHT");
				}
				
			}

//
//BUY CRAP
//	
			else if ((CON1 && CON1 == e.Args[0]) || (CON2 && CON2 == e.Args[0]))
			{
			
				if(Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row].items != "")
				{
			
					if (playa != null)
					{
						//Console.Printf("CALLING.");
						handler.HPIc_Buy(playa, Event.c_mode, Event.MCursor.Columnn, Event.MCursor.Row);
					}
					
				}
			
			}
	
			Event.player_item_amount = HPIc_RetrieveItemAmount(playa, Event.c_mode, Event.MCursor.Columnn, Event.MCursor.Row);
			
			}			
			
			//Console.PrintF("%d", m_mode);
			//Console.PrintF("POS: %d %d %s", Event.Mcursor.columnn, Event.Mcursor.row, Event.MenuOption[Event.MCursor.Columnn][Event.MCursor.Row].command); 
				
		}		
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
		MCursor.columnn = 0;
	}

}

// UI Scope: you cannot alter data here
override void renderOverlay(RenderEvent e)	// UI scope
{	

	int i0, i1, ia0, ia1, menui;
	HPICube_Func Event;
	HPICube_Items Items;
	Event = HPICube_Func(EventHandler.Find("HPICube_Func"));
	Items = HPICube_Items(EventHandler.Find("HPICube_Items"));
	
			
	if (showpic)
	{	

		for (ia0 = 0; ia0 < 2; ia0++)
		{
			for (ia1 = 0; ia1 < 7; ia1++)
			{
				Screen.DrawTexture(Items.Items[Event.c_mode][ia0][ia1].Item_V, false, (ia1 * 120) + 45, (ia0 * 150) + 150, DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);			
			}		
		}


		for (menui = 0; menui < 3; menui++)
		{
			Screen.DrawText(Confont, Font.CR_DARKGREEN, Event.MenuOption[0][menui].pos_x, Event.MenuOption[0][menui].pos_y, String.Format("[%s]", category[menui]), DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);
		}
		
		Screen.DrawTexture(Event.BlockLeft, false, Event.MenuOption[1][0].pos_x, Event.MenuOption[1][0].pos_y, DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);
		Screen.DrawTexture(Event.BlockRight, false, Event.MenuOption[1][1].pos_x, Event.MenuOption[1][1].pos_y, DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);

		Screen.DrawTexture(Event.BlockLeft, false, Event.MenuOption[2][0].pos_x, Event.MenuOption[2][0].pos_y, DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);
		Screen.DrawTexture(Event.BlockRight, false, Event.MenuOption[2][1].pos_x, Event.MenuOption[2][1].pos_y, DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);

//
//MENU MODE
//
		
		if (Event.m_mode == 0)
		{
		
		Screen.DrawTexture(Event.Cursor, false, 
							Event.MenuOption[Event.MCursor.columnn][Event.MCursor.row].cursor_x, 
							Event.MenuOption[Event.MCursor.columnn][Event.MCursor.row].cursor_y, 
							DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);
							
		}

//
//ITEMS MODE
//
		else if (Event.m_mode == 1)
		{
		
		Screen.DrawTexture(Event.Cursor, false,
							(Event.MCursor.Row * 120) + 90,
							(Event.MCursor.Columnn * 150) + 180,
							DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);
							
//DISPLAY SELECTION

		Screen.DrawTexture(Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row].Item_V, false, 940, 75, DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);
		
		Screen.DrawText(ConFont, Font.CR_GREEN, 580, 100, Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row].namee, DTA_VirtualWidth, 1280, DTA_VirtualHeight, 720);
		Screen.DrawText(Confont, Font.CR_GREEN, 580, 112, String.Format("Credits: %d", Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row].cost_credit), DTA_VirtualWidth, 1280, DTA_VirtualHeight, 720);
		Screen.DrawText(Confont, Font.CR_GREEN, 580, 122, String.Format("Metals: %d", Items.Items[Event.c_mode][Event.MCursor.Columnn][Event.MCursor.Row].cost_metal), DTA_VirtualWidth, 1280, DTA_VirtualHeight, 720);


		Screen.DrawText(Confont, Font.CR_GREEN, 580, 142, String.Format("Current: %d", Event.player_item_amount), DTA_VirtualWidth, 1280, DTA_VirtualHeight, 720);

		
		}
		
		
			
	}
}

static void HPIc_Buy(Actor self, int mode, int columnn, int row)
{

	HPICube_Items Items;
	Items = HPICube_Items(EventHandler.Find("HPICube_Items"));
	int amount;
	
	if (self.CountInv("MT_Credits") >= Items.Items[mode][columnn][row].cost_credit &&
		self.CountInv("MT_Metal") >= Items.Items[mode][columnn][row].cost_metal)
	{
	
		self.TakeInventory("MT_Credits", Items.Items[mode][columnn][row].cost_credit);
		self.TakeInventory("MT_Metal", Items.Items[mode][columnn][row].cost_metal);
		

		while (amount < Items.Items[mode][columnn][row].Item_Amount)
		{
			self.A_GiveInventory(Items.Items[mode][columnn][row].Items, 1);
			amount += 1;
		}
		
	}
}

static void HPIc_OpenMenu(Actor self)
{

	HPICube_Func Event;
	Event = HPICube_Func(EventHandler.Find("HPICube_Func"));
	
	if (self.CountInv("MT_HPICube_Item") == 1)
	{
		Event.toggle = 0; 
		self.A_Log("OFF");
		self.SetInventory("MT_HPICube_Item", 2);
		self.TakeInventory("ImCrafting", 99);
	}
	else if (self.CountInv("MT_HPICube_Item") == 2)
	{
		Event.toggle = 1;
		self.A_Log("ON");
		self.SetInventory("MT_HPICube_Item", 1);
		self.GiveInventory("ImCrafting", 99);
	}
	
	//Console.Printf("%d", Event.toggle);	
	
}

static int HPIc_RetrieveItemAmount(Actor self, Int Mode, Int Columnn, Int Row)
{
	HPICube_Items Items;
	Items = HPICube_Items(EventHandler.Find("HPICube_Items"));

	//Console.PrintF("%d", self.CountInv(Items.Items[Mode][Columnn][Row].Items));
	
	if (Mode == 0)
	{
		return self.CountInv(Items.Items[Mode][Columnn][Row].Original);
	}
	else if (Mode > 0)
	{
		return self.CountInv(Items.Items[Mode][Columnn][Row].Items);
	}
	
	return 0;
}


}


Class MT_HPICube_Item : CustomInventory
{

	Default
	{

		Inventory.Icon "FGRSB0";
		Inventory.PickupMessage "Picked up: HPI Cube";
		Inventory.Amount 1;
		Inventory.MaxAmount 2;
		Inventory.InterHubAmount 2;
		Tag "HPI Cube";
		
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

		let handler = HPICube_Func(EventHandler.Find('HPICube_Func'));

		if (handler == null) {}	
		else
		{
			let playa = PlayerPawn(self);

			if (playa != null)
			{

				handler.HPIc_OpenMenu(playa);

			}
		}

	}

}

