//------------------------------------------------------------------------------
//Crosshair Display
//------------------------------------------------------------------------------
/*
WARNING: Script is not complete.
*/
Class CrossHair_Display : EventHandler
{

	TextureID Crosshair;
	bool showpic;
	int toggle, Periscope;

override void WorldLoaded(WorldEvent e)
{
	Crosshair = TexMan.CheckForTexture ("TNHSA0", TexMan.Type_Any); 
	Periscope = 0;
}

// PLAY scope : collect data
override void WorldTick()	// PLAY scope
{
	let playa = players[0].mo;

	if (toggle == 1)
	{
		showpic = true;
		Periscope = CH_FindPeriscope(playa);
	}
	else
	{
		showpic = false;
	}

}

// UI Scope: you cannot alter data here
override void renderOverlay(RenderEvent e)	// UI scope
{	

	CrossHair_Display Event;
	Event = CrossHair_Display(EventHandler.Find("CrossHair_Display"));
	
	//TODO: Factor in Player camera pitch
			
	if (showpic)
	{	
	
	if (Event.Periscope == 0)
	{
		Screen.DrawTexture(Event.Crosshair, false, 800, 510, true, DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);					
	}
	else if (Event.Periscope == 1)
	{
		Screen.DrawTexture(Event.Crosshair, false, 800, 530, true, DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);					
	}
	else if (Event.Periscope == 2)
	{
		Screen.DrawTexture(Event.Crosshair, false, 800, 570, true, DTA_VirtualWidth, 1024, DTA_VirtualHeight, 768);					
	}
	
	
	}
}

static int CH_FindPeriscope(Actor self)
{

	if (self.CountInv("MT_Periscope", 0) == 1)
	{
		Return 1;
	}
	else if (self.CountInv("MT_Periscope", 0) == 2)
	{
		Return 2;
	}
	
	Return 0;
	
}

static void CH_Display(Actor self)
{

	CrossHair_Display Event;
	Event = CrossHair_Display(EventHandler.Find("CrossHair_Display"));
	
	if (self.CountInv("MT_ChaseCameraToken") == 1)
	{
		Event.toggle = 0; 
	}
	else if (self.CountInv("MT_ChaseCameraToken") == 2)
	{
		Event.toggle = 1;
	}
	
}


}


//-----------------------------------------------------------------------------
////Fake Chasecamera
//-----------------------------------------------------------------------------
Class MT_ChaseCameraToken : Inventory { Default {Inventory.MaxAmount 2;} }

Class MT_ChaseCamera_MK1 : CustomInventory
{ 

Default
{
  Inventory.Icon "NACOA0";
  Inventory.Amount 1;
  Inventory.MaxAmount 1;
  Inventory.PickupMessage "Picked up: Nightvision device (Green, poor quality)";
  Tag "(INT.) Personal. Remote. Camera (1:1 Quality)";
}
  states
  {
  Spawn:
  TNT1 A 1;
   loop;
  Use:
  TNT1 A 0;
  TNT1 A 0 A_PlaySound("V_Interact/NightVision");
  TNT1 A 0 A_GiveInventory("MT_Sound_Click", 1);
  TNT1 A 0 
	{
		CC_CallEm(self);
	}
  TNT1 A 0 A_JumpIf(CountInv("MT_ChaseCameraToken", 0) == 1, "On");
  goto Off;
  
  On:
	TNT1 A 0 A_SetInventory("MT_ChaseCameraToken", 2);
	fail;
  Off:
	TNT1 A 0 A_SetInventory("MT_ChaseCameraToken", 1);
	fail;
  
  
  }
  
static void CC_CallEm(Actor self)
	{

		let CC_handler = CrossHair_Display(EventHandler.Find('CrossHair_Display'));

		if (CC_handler == null) {}	
		else
		{
			let playa = PlayerPawn(self);


			if (playa != null)
			{

				Console.PrintF("FUCKED");
				CC_handler.CH_Display(playa);

			}
		}

	}
}