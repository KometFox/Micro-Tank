/*
Buy menu, refactor 2.
*/
Class HPIcube_Func : EventHandler
{
	bool Toggle, showpic;
	S_Cursor Cursor;
	S_ClassCost ClassCost[5];
	int sel_mode, cur_mode;
	
	Enum E_Menu
	{
		MENU_ = 0,
		U_WEAPONS = 1,
		C_WEAPONS = 2,
		ITEMS = 3,
		UPGRADE = 4,
	}

	Enum E_ClassCaliber
	{
		MEDIUM_50 = 0,
		MEDIUM_75 = 1,
		HEAVY_88 = 2,
		HEAVY_90 = 3,
		MBT_105 = 4,	
	}
	
	Enum E_Class
	{
		MEDIUM = 0,
		HEAVY = 1,
		MBT = 2,	
	}
	
	Struct S_Cursor
	{
		int row, column;
	}
	
	Struct S_ClassCost
	{
		string class_category;
		double class_cost_mult;
	}

override void WorldLoaded(WorldEvent e) 
{
	//Current selection
	sel_mode = C_WEAPONS;
	cur_mode = MENU_;
	
	//Class multiplier
	ClassCost[0].class_category = "MEDIUM_50mm";
	ClassCost[0].class_cost_mult = 1.0;

	ClassCost[1].class_category = "MEDIUM_75mm";
	ClassCost[1].class_cost_mult = 1.0;

	ClassCost[2].class_category = "HEAVY_88mm";
	ClassCost[2].class_cost_mult = 1.0;

	ClassCost[3].class_category = "HEAVY_90mm";
	ClassCost[3].class_cost_mult = 1.0;

	ClassCost[4].class_category = "MBT_105mm";
	ClassCost[4].class_cost_mult = 1.0;	
}

//------------------------------------------------------------------------------
//RENDERING CODE
//------------------------------------------------------------------------------
//Items display
ui void RenderItems(TextureID tex, int count0, int count1, int shift_x, int shift_y, int pos_x, int pos_y)
{
	Screen.DrawTexture(tex, false, (count0 * shift_x) + pos_x, (count1 * shift_y) + pos_y, DTA_KeepRatio, true, DTA_VirtualWidth, 1024 * 2, DTA_VirtualHeight, 768 * 2);
}

ui void RenderItems_Text(String Text, int sele, int count0, int count1, int shift_x, int shift_y, int pos_x, int pos_y)
{
	Switch(sele)
	{
	case(0):
		Screen.DrawText(Confont, Font.CR_DARKGREEN, (count0 * shift_x) + pos_x, (count1 * shift_y) + pos_y, Text);
		break;
	case(1):
		Screen.DrawText(Confont, Font.CR_GREEN, (count0 * shift_x) + pos_x, (count1 * shift_y) + pos_y, Text);
		break;
	}
}

//Other text display
ui void Render_Text(String Text, int pos_x, int pos_y)
{

}


override void renderOverlay(RenderEvent e)	// UI scope
{
	HPIc_CommonWeapon Items_CWeapon;
	Items_CWeapon = HPIc_CommonWeapon(EventHandler.Find("HPIc_CommonWeapon"));
	
	HPIc_ItemContainer EV_Items;
		
	//Text, Item position
	int item_pos_x, item_pos_y, item_shift_x, item_shift_y;
	int text_pos_x, text_pos_y, text_shift_x, text_shift_y;
	//Array size
	int array_d1, array_d2;
	
	//Item
	item_pos_x = 700;
	item_pos_y = 400;
	item_shift_x = 140;
	item_shift_y = 150;
	//Text
	text_pos_x = 680;
	text_pos_y = 380;
	text_shift_x = 150;
	text_shift_y = 200;

	if (Showpic)
	{
		//Set the maximum size.
		if (sel_mode == U_WEAPONS)
		{
			array_d1 = 0;
			array_d2 = 0;
			EV_Items = HPIc_CommonWeapon(EventHandler.Find("HPIc_CommonWeapon"));
		}
		else if (sel_mode == C_WEAPONS)
		{
			array_d1 = 1;
			array_d2 = 5;
			EV_Items = HPIc_CommonWeapon(EventHandler.Find("HPIc_CommonWeapon"));
		}
		else if (sel_mode == ITEMS)
		{
			array_d1 = 0;
			array_d2 = 0;
			EV_Items = HPIc_CommonWeapon(EventHandler.Find("HPIc_CommonWeapon"));
		}
		else if (sel_mode == UPGRADE)
		{
			array_d1 = 0;
			array_d2 = 0;
			EV_Items = HPIc_CommonWeapon(EventHandler.Find("HPIc_CommonWeapon"));
		}


		//Loop through the items and display them.
		/*
		for (int i0 = 0; i0 < array_d1; i0++)
		{
			for (int i1 = 0; i1 < array_d2; i1++)
			{
				RenderItems(EV_Items.Items[i0][i1].Sprite, i1, i0, item_shift_x, item_shift_y, item_pos_x, item_pos_y);
				if (Cursor.Row == i0 && Cursor.Column == i1)
				{
					RenderITems_Text("[*]", 0, i1, i0, text_shift_x, text_shift_y, text_pos_x, text_pos_y);
				}
				else
				{
					RenderITems_Text("[ ]", 0, i1, i0, text_shift_x, text_shift_y, text_pos_x, text_pos_y);
				}
			}				
		}
		*/
				
	}
}

//------------------------------------------------------------------------------
//INPUT CODE
//------------------------------------------------------------------------------
void Cursor_Mover(string move_to, int max_row, int max_column)
{
	if (move_to == "RIGHT")
	{
		if (Cursor.column < max_column)
		{
			Cursor.column += 1;
		}	
	}
	else if (move_to == "LEFT")
	{
		if (Cursor.column > 0)
		{
			Cursor.column -= 1;
		}	
	}

	else if (move_to == "DOWN")
	{
		if (Cursor.row < max_row)
		{
			Cursor.row += 1;
		}
	}
	else if (move_to == "UP")
	{
		if (Cursor.row > 0)
		{
			Cursor.row -= 1;
		}	
	}

}

override void NetworkProcess(ConsoleEvent e)
{        
	int menu_selection, array_x_limit, array_y_limit;
	menu_selection = 0;
	
	HPIc_CommonWeapon Items_CWeapon;
	Items_CWeapon = HPIc_CommonWeapon(EventHandler.Find("HPIc_CommonWeapon"));	
	
	int FO1, FO2;
	int BA1, BA2;
	int ML1, ML2;
	int MR1, MR2;
	int Con1, Con2;
	[FO1, FO2] = Bindings.GetKeysForCommand("+forward");
	[BA1, BA2] = Bindings.GetKeysForCommand("+back");
	[ML1, ML2] = Bindings.GetKeysForCommand("+moveleft");
	[MR1, MR2] = Bindings.GetKeysForCommand("+moveright");
	[Con1, Con2] = Bindings.GetKeysForCommand("+use");

	if (toggle == 1)
	{
		if (sel_mode == MENU_)
		{
			array_x_limit = 3;
			array_y_limit = 1;
		}
		if (sel_mode == C_WEAPONS)
		{
			array_x_limit = Items_CWeapon.Array_X;
			array_y_limit = Items_CWeapon.Array_Y;
		}
		else if (sel_mode == U_WEAPONS)
		{
			array_x_limit = Items_CWeapon.Array_X;
			array_y_limit = Items_CWeapon.Array_Y;
		}
		else if (sel_mode == ITEMS)
		{
			array_x_limit = Items_CWeapon.Array_X;
			array_y_limit = Items_CWeapon.Array_Y;
		}
		else if (sel_mode == UPGRADE)
		{
			array_x_limit = Items_CWeapon.Array_X;
			array_y_limit = Items_CWeapon.Array_Y;
		}

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
	
	}		
	
}
	
	


override void WorldTick()	// PLAY scope
{

	if (Toggle == True)
	{
		Showpic = True;
	}
	else
	{
		Showpic = False;
		Cursor.row = 0;
		Cursor.column = 0;
	}

}


static void HPIc_OpenMenu(Actor self)
{
	HPICube_Func Event;
	Event = HPICube_Func(EventHandler.Find("HPICube_Func"));
	
	if (self.CountInv("MT_HPICube_Item") == 1)
	{
		Event.toggle = false; 
		self.SetInventory("MT_HPICube_Item", 2);
		self.TakeInventory("ImCrafting", 99);
	}
	else if (self.CountInv("MT_HPICube_Item") == 2)
	{
		Event.toggle = true;
		self.SetInventory("MT_HPICube_Item", 1);
		self.GiveInventory("ImCrafting", 99);
	}
}


}
















Class MT_HPICube_Item : MT_SPlayerCustomInventory
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

