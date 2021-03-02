Class HUD_AmmoDisplay : EventHandler
{
	//Define player resolution
	int vid_Width, vid_Height;

	//Ammo...
	TextureID Sprite;
	String AmmoName, AmmoItem;
	Int AmmoCount, AmmoCount_Max;

override void renderOverlay(RenderEvent e)	// UI scope
{
	//Needs to be part of the loop.
	Vector2 hudScale = StatusBar.GetHUDScale();
	int vw = screen.GetWidth() / hudScale.x;
    int vh = screen.GetHeight() / hudScale.x;

	if (AmmoName)	
	{	
		///
		//Screen.DrawText(CONFONT, Font.CR_WHITE, (150) + (vid_Width), (-80) + (vid_Height), AmmoName);
		///
		//Ammo Display
        Screen.DrawTexture(Sprite, false, vw - 140, vh - 131, 
		DTA_KeepRatio, true, DTA_VirtualWidth, vw, DTA_VirtualHeight, vh);
		//Ammo Name
		Screen.DrawText(SMALLFONT, Font.CR_WHITE, vw - 250, vh - 86, AmmoName, 
		DTA_KeepRatio, true, DTA_VirtualWidth, vw, DTA_VirtualHeight, vh, DTA_CellX, 12, DTA_CellY, 12);
		//Ammo Count
		Screen.DrawText(SMALLFONT, Font.CR_WHITE, vw - 160, vh - 120, String.Format("%d", AmmoCount),
		DTA_KeepRatio, true, DTA_VirtualWidth, vw, DTA_VirtualHeight, vh, DTA_CellX, 12, DTA_CellY, 12);
		//Ammo Max Count
      
	}
}

override void WorldTick()
{
	let player = players[0].mo;

	if (player != null)
	{
		AmmoCount = player.CountInv(AmmoItem, AAPTR_DEFAULT);
	}
}


Static void Set_AmmoName(string str)
{
	HUD_AmmoDisplay HUD_AD;
	HUD_AD = HUD_AmmoDisplay(EventHandler.Find("HUD_AmmoDisplay"));
	
	HUD_AD.AmmoName = str;
}

Static void Set_AmmoCount(int amount)
{
	HUD_AmmoDisplay HUD_AD;
	HUD_AD = HUD_AmmoDisplay(EventHandler.Find("HUD_AmmoDisplay"));
	
	HUD_AD.AmmoCount = amount;
}

Static void Set_AmmoItem(string Item)
{
	HUD_AmmoDisplay HUD_AD;
	HUD_AD = HUD_AmmoDisplay(EventHandler.Find("HUD_AmmoDisplay"));
	
	HUD_AD.AmmoItem = Item;
}

Static void Set_Sprite(TextureID ID)
{
	HUD_AmmoDisplay HUD_AD;
	HUD_AD = HUD_AmmoDisplay(EventHandler.Find("HUD_AmmoDisplay"));
	
	HUD_AD.Sprite = ID;
}

}



