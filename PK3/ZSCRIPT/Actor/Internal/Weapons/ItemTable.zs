/*
	List of Items.
*/

Struct S_Explosives
{
	string Name_;
	double Amount;
}


Class Explosives_Table : EventHandler
{
	const C_ITEMS = 2;
	S_Explosives Explosives[C_ITEMS];
	
	override void WorldLoaded(WorldEvent e)
	{
		Explosives[0].Name_ = "TNT";
		Explosives[0].Amount = 1.0;
		Explosives[1].Name_ = "Np10";
		Explosives[1].Amount = 1.7;
	}
	
	static double Get_Amount(string Item)
	{
		Explosives_Table ET;
		ET = Explosives_Table(EventHandler.Find("Explosives_Table"));
		
		if (ET)
		{
			for (int i = 0; i < ET.C_ITEMS; i++)
			{
				if (ET.Explosives[i].Name_ == Item)
				{
					return ET.Explosives[i].Amount;
				}			
			}		
		}		
		return 0.0;
	}	
}

