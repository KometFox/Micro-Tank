Class HUD_AmmoDisplay : EventHandler
{
	//Get player resolution
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


	if (Sprite && AmmoName)
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



/*
Class MT_HUD : BaseStatusBar
{
	//Constants
	const AMMODISPLAY_X = 568;
	const AMMODISPLAY_Y = 200;

	//HUD Shit
	HUDFont Blin;
	
	TextureID AmmoDisplay, StatusDisplay;

	//Ammo
	TextureID AmmoSprite;
	String AmmoName, AmmoItem;
	Int AmmoCount, AmmoCount_Max;


override void Init()
{
	Super.Init();
	
	Blin = HUDFont.Create(SMALLFONT);
	AmmoDisplay = TexMan.CheckForTexture ("MTHSA", TexMan.Type_Any);
}

override void Draw(int state, double TicFrac)
{
	Super.Draw(state, TicFrac);
	
	if (state == HUD_StatusBar)
	{
		Draw_HUD();
	}
	else if (state == HUD_FullScreen)
	{
		Draw_HUD();
	}
	
}


void Draw_HUD()
{

	//StatusBar.DrawText(CONFONT, Font.CR_WHITE, 160, 120, String.Format("%d", AmmoCount));
	DrawString(Blin, String.Format("%d", AmmoCount), (AMMODISPLAY_X - 35, AMMODISPLAY_Y - 60));
	
	//Left Display
	
	//Right Display
	DrawTexture(AmmoDisplay, (AMMODISPLAY_X, AMMODISPLAY_Y), 0, 1, (-1, -1), (0.5, 0.5));
}



override void Tick()
{
	Super.Tick();

	AmmoCount = HUD_RetrieveInfo.get_AmmoCount();
}



}

Class HUD_RetrieveInfo : EventHandler
{
	Int AmmoCount;

	static void set_AmmoCount(int amount)
	{
		HUD_RetrieveInfo HUD_RI;
		HUD_RI = HUD_RetrieveInfo(EventHandler.Find("HUD_RetrieveInfo"));
		
		HUD_RI.AmmoCount = amount;
	}
	
	ui static int get_AmmoCount()
	{
		HUD_RetrieveInfo HUD_RI;
		HUD_RI = HUD_RetrieveInfo(EventHandler.Find("HUD_RetrieveInfo"));
	
		return HUD_RI.AmmoCount;
	}

}

*/


