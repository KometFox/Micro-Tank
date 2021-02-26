/*
Used for retrieving list of class specific items.
*/
Class HPICube_Items : EventHandler
{

	const array_i = 2;
	const array_si = 7;
	Item Items[3][50][50];
/*
Items[0][X][X] = WEAPONS
Items[1][X][X] = AUXILLARY
Items[2][X][X] = UPGRADE
*/
	Resource Resources;

	
struct Resource
{
	TextureID R_Credit, R_Metal;
	String Str_Credit, Str_Metal;
}

struct Item
{
	int cost_credit, cost_metal, item_amount;
	string Items, p_class[2], namee, original;
	TextureID Item_V;
}

override void WorldLoaded(WorldEvent e)
{
//------------------------------------------------------------------------------
//RESOURCE
//------------------------------------------------------------------------------
	Resources.R_Credit = TexMan.CheckForTexture("CREDA0", TexMan.Type_Any);
	Resources.R_Metal = TexMan.CheckForTexture("METBA0", TexMan.Type_Any);
	Resources.Str_Credit = "Credits";
	Resources.Str_Metal = "Metal";

//------------------------------------------------------------------------------
//WEAPON ITEMS
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//105mm Gun
//------------------------------------------------------------------------------
	Items[0][0][0].cost_credit = 8;
	Items[0][0][0].cost_metal = 0;
	Items[0][0][0].item_amount = 1;
	Items[0][0][0].Items = "MTAmmoBox_SC_Bulletbox";
	Items[0][0][0].original = "A_7u62x54mmR";
	Items[0][0][0].namee = "Cannon";
	Items[0][0][0].Item_V = TexMan.CheckForTexture ("ICAGA0", TexMan.Type_Any);

	Items[0][0][1].cost_credit = 8;
	Items[0][0][1].cost_metal = 0;
	Items[0][0][1].item_amount = 1;
	Items[0][0][1].Items = "MTAmmoBox_SC_Bulletbox";
	Items[0][0][1].original = "A_7u62x54mmR";
	Items[0][0][1].namee = "Ball Cartridges";
	Items[0][0][1].Item_V = TexMan.CheckForTexture ("IBUAA0", TexMan.Type_Any);

	Items[0][0][2].cost_credit = 40;
	Items[0][0][2].cost_metal = 0;
	Items[0][0][2].item_amount = 1;
	Items[0][0][2].Items = "MTAmmoBox_AP";
	Items[0][0][2].original = "MT_75x500mmAP";
	Items[0][0][2].namee = "APHE";
	Items[0][0][2].Item_V = TexMan.CheckForTexture ("IAPAA0", TexMan.Type_Any);

	Items[0][0][3].cost_credit = 85;
	Items[0][0][3].cost_metal = 8;
	Items[0][0][3].item_amount = 1;
	Items[0][0][3].Items = "MTAmmoBox_APCR";
	Items[0][0][3].original = "MT_75x500mmAPCR";
	Items[0][0][3].namee = "U-APFSDS";
	Items[0][0][3].Item_V = TexMan.CheckForTexture ("IAPFA0", TexMan.Type_Any);

	Items[0][0][4].cost_credit = 30;
	Items[0][0][4].cost_metal = 0;
	Items[0][0][4].item_amount = 1;
	Items[0][0][4].Items = "MTAmmoBox_HE";
	Items[0][0][4].original = "MT_75x500mmHE";
	Items[0][0][4].namee = "HE";
	Items[0][0][4].Item_V = TexMan.CheckForTexture ("IHEAA0", TexMan.Type_Any);

	Items[0][0][5].cost_credit = 25;
	Items[0][0][5].cost_metal = 0;
	Items[0][0][5].item_amount = 1;
	Items[0][0][5].Items = "MTAmmoBox_Buckshot";
	Items[0][0][5].original = "MT_75x500mmBee";
	Items[0][0][5].namee = "Bee";
	Items[0][0][5].Item_V = TexMan.CheckForTexture ("IBKAA0", TexMan.Type_Any);
	
	Items[0][0][6].cost_credit = 48;
	Items[0][0][6].cost_metal = 12;
	Items[0][0][6].item_amount = 1;
	Items[0][0][6].Items = "MTAmmoBox_Chem";
	Items[0][0][6].original = "MT_75x500mmChem";
	Items[0][0][6].namee = "Chemical";
	Items[0][0][6].Item_V = TexMan.CheckForTexture ("ICHSA0", TexMan.Type_Any);	

	
//------------------------------------------------------------------------------
//AUXILLARY ITEMS
//------------------------------------------------------------------------------
	Items[1][0][0].cost_credit = 15;
	Items[1][0][0].cost_metal = 0;
	Items[1][0][0].item_amount = 50;
	Items[1][0][0].Items = "MT_Spareparts";
	Items[1][0][0].namee = "Spare Parts";
	Items[1][0][0].Item_V = TexMan.CheckForTexture ("ISPPA0", TexMan.Type_Any);	

	Items[1][0][1].cost_credit = 3;
	Items[1][0][1].cost_metal = 0;
	Items[1][0][1].item_amount = 4;
	Items[1][0][1].Items = "MT_Item_GrenadePod_Flare";
	Items[1][0][1].namee = "Flare (Grenade Pod)";
	Items[1][0][1].Item_V = TexMan.CheckForTexture ("IPGFA0", TexMan.Type_Any);

	Items[1][0][2].cost_credit = 4;
	Items[1][0][2].cost_metal = 0;
	Items[1][0][2].item_amount = 4;
	Items[1][0][2].Items = "Item_GrenadePod_Illuminating";
	Items[1][0][2].namee = "Illuminating (Grenade Pod)";
	Items[1][0][2].Item_V = TexMan.CheckForTexture ("IPGIA0", TexMan.Type_Any);
	
	Items[1][0][3].cost_credit = 12;
	Items[1][0][3].cost_metal = 0;
	Items[1][0][3].item_amount = 4;
	Items[1][0][3].Items = "MT_GrenadePod_Explosive";
	Items[1][0][3].namee = "Explosive (Grenade Pod)";
	Items[1][0][3].Item_V = TexMan.CheckForTexture ("IPGHA0", TexMan.Type_Any);
	
	Items[1][0][4].cost_credit = 20;
	Items[1][0][4].cost_metal = 0;
	Items[1][0][4].item_amount = 4;
	Items[1][0][4].Items = "MT_Item_GrenadePod_MolotovGrenade";
	Items[1][0][4].namee = "Molotov (Grenade Pod)";
	Items[1][0][4].Item_V = TexMan.CheckForTexture ("IPGMA0", TexMan.Type_Any);	
	
	Items[1][0][5].cost_credit = 2000;
	Items[1][0][5].cost_metal = 0;
	Items[1][0][5].item_amount = 1;
	Items[1][0][5].Items = "Item_GrenadePod_ScudStrike";
	Items[1][0][5].namee = "Scud Strike Marker (Special)";
	Items[1][0][5].Item_V = TexMan.CheckForTexture ("ISCUA0", TexMan.Type_Any);	

	Items[1][0][6].cost_credit = 300;
	Items[1][0][6].cost_metal = 0;
	Items[1][0][6].item_amount = 1;
	Items[1][0][6].Items = "MT_AmmoExtender";
	Items[1][0][6].namee = "Ammo Extender (Special)";
	Items[1][0][6].Item_V = TexMan.CheckForTexture ("IBKPA0", TexMan.Type_Any);	

	Items[1][1][0].cost_credit = 75;
	Items[1][1][0].cost_metal = 0;
	Items[1][1][0].item_amount = 1;
	Items[1][1][0].Items = "MT_Item_AnthraxGasGenerator";
	Items[1][1][0].namee = "Anthrax Sprayer (Special)";
	Items[1][1][0].Item_V = TexMan.CheckForTexture ("IANTA0", TexMan.Type_Any);	
	
//------------------------------------------------------------------------------
//AUXILLARY ITEMS
//------------------------------------------------------------------------------
	Items[2][0][0].cost_credit = 0;
	Items[2][0][0].cost_metal = 60;
	Items[2][0][0].item_amount = 1;
	Items[2][0][0].Items = "MT_Upgrade_CannonFiringRate_1";
	Items[2][0][0].namee = "Cannon Firing Rate (T1)";
	Items[2][0][0].original = "MTU_FastCannon_2";
	Items[2][0][0].Item_V = TexMan.CheckForTexture ("ICAGA0", TexMan.Type_Any);

	Items[2][0][1].cost_credit = 0;
	Items[2][0][1].cost_metal = 50;
	Items[2][0][1].item_amount = 1;
	Items[2][0][1].Items = "MT_HEShell_Upgrader2";
	Items[2][0][1].namee = "High Explosive Ammo (T1)";
	Items[2][0][1].original = "MTU_HEShell_2";
	Items[2][0][1].Item_V = TexMan.CheckForTexture ("IHEAB0", TexMan.Type_Any);
	
	Items[2][0][2].cost_credit = 0;
	Items[2][0][2].cost_metal = 75;
	Items[2][0][2].item_amount = 1;
	Items[2][0][2].Items = "MT_HEShell_Upgrader3";
	Items[2][0][2].namee = "High Explosive Ammo (T2)";
	Items[2][0][2].original = "MTU_HEShell_2";
	Items[2][0][2].Item_V = TexMan.CheckForTexture ("IHEAC0", TexMan.Type_Any);
	
	Items[2][0][3].cost_credit = 0;
	Items[2][0][3].cost_metal = 50;
	Items[2][0][3].item_amount = 1;
	Items[2][0][3].Items = "MT_APShot_Upgrader2";
	Items[2][0][3].namee = "Armor Piercing Ammo (T1)";
	Items[2][0][3].original = "MTU_APShot_2";
	Items[2][0][3].Item_V = TexMan.CheckForTexture ("IAPAB0", TexMan.Type_Any);
	
	Items[2][0][4].cost_credit = 0;
	Items[2][0][4].cost_metal = 75;
	Items[2][0][4].item_amount = 1;
	Items[2][0][4].Items = "MT_APShot_Upgrader3";
	Items[2][0][4].namee = "Armor Piercing Ammo (T2)";
	Items[2][0][4].original = "MTU_APShot_2";
	Items[2][0][4].Item_V = TexMan.CheckForTexture ("IAPAC0", TexMan.Type_Any);
	
	Items[2][0][5].cost_credit = 0;
	Items[2][0][5].cost_metal = 50;
	Items[2][0][5].item_amount = 1;
	Items[2][0][5].Items = "MT_Buckshot_Upgrader2";
	Items[2][0][5].namee = "00 Buckshot Ammo (T1)";
	Items[2][0][5].original = "MTU_BuckShotShell_2";
	Items[2][0][5].Item_V = TexMan.CheckForTexture ("IBKAB0", TexMan.Type_Any);
	
	Items[2][0][6].cost_credit = 0;
	Items[2][0][6].cost_metal = 75;
	Items[2][0][6].item_amount = 1;
	Items[2][0][6].Items = "MT_Buckshot_Upgrader3";
	Items[2][0][6].namee = "00 Buckshot Ammo (T2)";
	Items[2][0][6].original = "MTU_BuckShotShell_2";
	Items[2][0][6].Item_V = TexMan.CheckForTexture ("IBKAC0", TexMan.Type_Any);
	
	Items[2][1][0].cost_credit = 0;
	Items[2][1][0].cost_metal = 50;
	Items[2][1][0].item_amount = 1;
	Items[2][1][0].Items = "MT_ChemShell_Upgrader2";
	Items[2][1][0].namee = "Chemical Ammo (T1)";
	Items[2][1][0].original = "MTU_ChemShell_2";
	Items[2][1][0].Item_V = TexMan.CheckForTexture ("ICHSB0", TexMan.Type_Any);
	
	Items[2][1][1].cost_credit = 0;
	Items[2][1][1].cost_metal = 75;
	Items[2][1][1].item_amount = 1;
	Items[2][1][1].Items = "MT_ChemShell_Upgrader3";
	Items[2][1][1].namee = "Chemical Ammo (T2)";
	Items[2][1][1].original = "MTU_ChemShell_2";
	Items[2][1][1].Item_V = TexMan.CheckForTexture ("ICHSC0", TexMan.Type_Any);
	
	Items[2][1][2].cost_credit = 0;
	Items[2][1][2].cost_metal = 25;
	Items[2][1][2].item_amount = 1;
	Items[2][1][2].Items = "MT_Upgrade_Armor_EnvironmentCoat";
	Items[2][1][2].namee = "Environmental Hazard Coating (Armor Addon)";
	Items[2][1][2].original = "PowerMT_NBC_Coating";
	Items[2][1][2].Item_V = TexMan.CheckForTexture ("IHAMA0", TexMan.Type_Any);
	
	Items[2][1][3].cost_credit = 0;
	Items[2][1][3].cost_metal = 100;
	Items[2][1][3].item_amount = 1;
	Items[2][1][3].Items = "MT_Upgrade_Aux_SupplyBox";
	Items[2][1][3].namee = "Supply Crate (T1)";
	Items[2][1][3].original = "MTU_SupplyBox_2";
	Items[2][1][3].Item_V = TexMan.CheckForTexture ("SUPBAB0", TexMan.Type_Any);

}

}
