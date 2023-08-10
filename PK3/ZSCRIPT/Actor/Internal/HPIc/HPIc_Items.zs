Mixin Class B_Items
{

struct S_Resource
{
	TextureID R_Credit, R_Metal;
	String Str_Credit, Str_Metal;
};

struct S_Item
{
	int cost_credit, cost_metal, amount;
	string Item, Name_, Item_Original;
	TextureID Sprite;
};

}

Class HPIc_ItemContainer : EventHandler
{
	Mixin B_Items;
	//S_Item Items[1][1];
}

struct S_Item
{
	int cost_credit, cost_metal, amount;
	string Item, Name_, Item_Original;
	TextureID Sprite;
};

Class HPIc_CommonItem : HPIc_ItemContainer
{
	S_Item Items[1][4];


	override void WorldLoaded(WorldEvent e)
	{	
		Items[0][0].Name_ = "Ball Cartridge";
		Items[0][0].Item = "Clip";
		Items[0][0].Item_Original = "Clip";
		Items[0][0].Sprite = TexMan.CheckForTexture("ISPPA0", TexMan.Type_Any);
		Items[0][0].cost_credit = 1;
		Items[0][0].cost_metal = 0;
		Items[0][0].amount = 100;
		
		Items[0][1].Name_ = "Spare Parts";
		Items[0][1].Item = "Clip";
		Items[0][1].Item_Original = "Clip";
		Items[0][1].Sprite = TexMan.CheckForTexture("ISPPA0", TexMan.Type_Any);
		Items[0][1].cost_credit = 5;
		Items[0][1].cost_metal;

		Items[0][2].Name_ = "Spare Parts";
		Items[0][2].Item = "Clip";
		Items[0][2].Item_Original = "Clip";
		Items[0][2].Sprite = TexMan.CheckForTexture("ISPPA0", TexMan.Type_Any);
		Items[0][2].cost_credit = 5;
		Items[0][2].cost_metal;

		Items[0][3].Name_ = "Spare Parts";
		Items[0][3].Item = "Clip";
		Items[0][3].Item_Original = "Clip";
		Items[0][3].Sprite = TexMan.CheckForTexture("ISPPA0", TexMan.Type_Any);
		Items[0][3].cost_credit = 5;
		Items[0][3].cost_metal;
	}



}

//"Unique" weapons, caliber tied weapons
Class HPIc_UniqueWeapon : HPIc_ItemContainer
{
	S_Item Items[3][1][4];
	
	Enum Classes
	{
		MEDIUM_50 = 0,
		MEDIUM_75 = 1,
		HEAVY_88 = 2,
		HEAVY_90 = 3,
		MBT_105 = 4,
	}
	
	override void WorldLoaded(WorldEvent e)
	{
		//MEDIUM, 50mm cannon
		Items[MEDIUM_50][0][0].Name_ = "50mm Cannon";
		Items[MEDIUM_50][0][0].Item = "MT_50mmCannon";
		Items[MEDIUM_50][0][0].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_50][0][0].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_50][0][0].cost_credit = 1;
		Items[MEDIUM_50][0][0].cost_metal = 0;
		Items[MEDIUM_50][0][0].amount = 1;
		
		Items[MEDIUM_50][0][1].Name_ = "APHE";
		Items[MEDIUM_50][0][1].Item = "MT_50mmCannon";
		Items[MEDIUM_50][0][1].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_50][0][1].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_50][0][1].cost_credit = 1;
		Items[MEDIUM_50][0][1].cost_metal = 0;
		Items[MEDIUM_50][0][1].amount = 1;
		
		Items[MEDIUM_50][0][2].Name_ = "APCR";
		Items[MEDIUM_50][0][2].Item = "MT_50mmCannon";
		Items[MEDIUM_50][0][2].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_50][0][2].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_50][0][2].cost_credit = 1;
		Items[MEDIUM_50][0][2].cost_metal = 0;
		Items[MEDIUM_50][0][2].amount = 1;
		
		Items[MEDIUM_50][0][3].Name_ = "HE";
		Items[MEDIUM_50][0][3].Item = "MT_50mmCannon";
		Items[MEDIUM_50][0][3].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_50][0][3].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_50][0][3].cost_credit = 1;
		Items[MEDIUM_50][0][3].cost_metal = 0;
		Items[MEDIUM_50][0][3].amount = 1;
		
		//MEDIUM, 75mm cannon
		Items[MEDIUM_75][0][0].Name_ = "75mm Cannon";
		Items[MEDIUM_75][0][0].Item = "MT_50mmCannon";
		Items[MEDIUM_75][0][0].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_75][0][0].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_75][0][0].cost_credit = 1;
		Items[MEDIUM_75][0][0].cost_metal = 0;
		Items[MEDIUM_75][0][0].amount = 1;
		
		Items[MEDIUM_75][0][1].Name_ = "APHE";
		Items[MEDIUM_75][0][1].Item = "MT_50mmCannon";
		Items[MEDIUM_75][0][1].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_75][0][1].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_75][0][1].cost_credit = 1;
		Items[MEDIUM_75][0][1].cost_metal = 0;
		Items[MEDIUM_75][0][1].amount = 1;
		
		Items[MEDIUM_75][0][2].Name_ = "APCR";
		Items[MEDIUM_75][0][2].Item = "MT_50mmCannon";
		Items[MEDIUM_75][0][2].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_75][0][2].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_75][0][2].cost_credit = 1;
		Items[MEDIUM_75][0][2].cost_metal = 0;
		Items[MEDIUM_75][0][2].amount = 1;
		
		Items[MEDIUM_75][0][3].Name_ = "HE";
		Items[MEDIUM_75][0][3].Item = "MT_50mmCannon";
		Items[MEDIUM_75][0][3].Item_Original = "MT_50mmCannon";
		Items[MEDIUM_75][0][3].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[MEDIUM_75][0][3].cost_credit = 1;
		Items[MEDIUM_75][0][3].cost_metal = 0;
		Items[MEDIUM_75][0][3].amount = 1;
		
		//HEAVY, 88mm cannon
		
		//HEAVY, 90mm cannon
		
		//MBT, 105mm cannon
	}

}

//Common weapons, tied to class category
Class HPIc_CommonWeapon : HPIc_ItemContainer
{
	S_Item Items[2][5];
	int Array_X, Array_Y;
	
	override void WorldLoaded(WorldEvent e)
	{
		Array_X = 2;
		Array_Y = 5;

		//CANNON
		Items[0][0].Name_ = "Cannon";
		Items[0][0].Item = "MT_50mmCannon";
		Items[0][0].Item_Original = "MT_50mmCannon";
		Items[0][0].Sprite = TexMan.CheckForTexture("ICAGA0", TexMan.Type_Any);
		Items[0][0].cost_credit = 1;
		Items[0][0].cost_metal = 0;
		Items[0][0].amount = 1;
		
		Items[0][1].Name_ = "APHE";
		Items[0][1].Item = "MT_50mmCannon";
		Items[0][1].Item_Original = "MT_50mmCannon";
		Items[0][1].Sprite = TexMan.CheckForTexture("IAPAA0", TexMan.Type_Any);
		Items[0][1].cost_credit = 1;
		Items[0][1].cost_metal = 0;
		Items[0][1].amount = 1;
		
		Items[0][2].Name_ = "AP+";
		Items[0][2].Item = "MT_50mmCannon";
		Items[0][2].Item_Original = "MT_50mmCannon";
		Items[0][2].Sprite = TexMan.CheckForTexture("IAPFA0", TexMan.Type_Any);
		Items[0][2].cost_credit = 1;
		Items[0][2].cost_metal = 0;
		Items[0][2].amount = 1;
		
		Items[0][3].Name_ = "HE";
		Items[0][3].Item = "MT_50mmCannon";
		Items[0][3].Item_Original = "MT_50mmCannon";
		Items[0][3].Sprite = TexMan.CheckForTexture("IHEAA0", TexMan.Type_Any);
		Items[0][3].cost_credit = 1;
		Items[0][3].cost_metal = 0;
		Items[0][3].amount = 1;
		
		Items[0][4].Name_ = "Bee";
		Items[0][4].Item = "MT_50mmCannon";
		Items[0][4].Item_Original = "MT_50mmCannon";
		Items[0][4].Sprite = TexMan.CheckForTexture("IBKAA0", TexMan.Type_Any);
		Items[0][4].cost_credit = 1;
		Items[0][4].cost_metal = 0;
		Items[0][4].amount = 1;		
		//
	}

}

Class HPIc_UpgradeItem : HPIc_ItemContainer
{
	S_Item Items[2][2];
	
	override void WorldLoaded(WorldEvent e)
	{
	
	
	}

}

class craft_info
{
    string Name_;
    string Item;
    string Item_Original;
    string Sprite;
    int cost_credit;
    int cost_metal;
    int amount;

    static craft_info create_new(string name, string item_1, string item_orig, string sprite_id, int cost_cred, int cost_met, int count)
    {
        craft_info inf = new("craft_info");

        inf.Name_ = name;
        inf.Item = item_1;
        inf.Item_Original = item_orig;
        inf.Sprite = sprite_id;
        inf.cost_credit = cost_cred;
        inf.cost_metal = cost_met;
        inf.amount = count;

        return inf;
    }
}

class Container : EventHandler
{	
	array<craft_info> Box;

	override void WorldLoaded(WorldEvent e)
	{
		Box.Push(craft_info.create_new("Cannon",
										"MT_50mmCannon", 
										"MT_50mmCannon",
										"ICAGA0",
										1,
										0,
										1));
										
		Console.PrintF("AAA");
		Console.PrintF("HUUH: %s", Box[0]);
	}

}



