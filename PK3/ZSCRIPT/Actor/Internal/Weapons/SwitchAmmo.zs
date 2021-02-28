Class AmmoSwitcher : EventHandler
{

	int Ammo_Selected, AmmoType_Max;
	object gun_invoker;


override void Networkprocess(ConsoleEvent e)
{
	
		int ML1, ML2;
		int MR1, MR2;
		[ML1, ML2] = Bindings.GetKeysForCommand("MTC_AmoSwcL");
		[MR1, MR2] = Bindings.GetKeysForCommand("MTC_AmoSwcR");

		if ((ML1 && ML1 == e.Args[0]) || (ML2 && ML2 == e.Args[0]))
		{
			if (Ammo_Selected < AmmoType_Max)
			{
				Ammo_Selected += 1;
			}
			else
			{
				Ammo_Selected = 0;
			}
			
			if (gun_invoker != null)
			{
				MT_BaseCannon.Set_Loaded_Projectile(gun_invoker, Ammo_Selected);
			}
			//Console.PrintF("%d", Ammo_Selected);
			
		}
		else if ((MR1 && MR1 == e.Args[0]) || (MR2 && MR2 == e.Args[0]))
		{
			if (Ammo_Selected > 0)
			{
				Ammo_Selected -= 1;
			}
			else
			{
				Ammo_Selected = AmmoType_Max;
			}
			
			if (gun_invoker != null)
			{
				MT_BaseCannon.Set_Loaded_Projectile(gun_invoker, Ammo_Selected);
			}
			//Console.PrintF("%d", Ammo_Selected);
		}


}


//Setters
static void Set_Ammo_Selected(int amount)
{
	AmmoSwitcher AS;
	AS = AmmoSwitcher(EventHandler.Find("AmmoSwitcher"));
	
	AS.Ammo_Selected = amount;
}

static void Set_AmmoType_Max(int amount)
{
	AmmoSwitcher AS;
	AS = AmmoSwitcher(EventHandler.Find("AmmoSwitcher"));
	
	AS.AmmoType_Max = amount;
}

static void Set_Gun_Invoker(object mo)
{
	AmmoSwitcher AS;
	AS = AmmoSwitcher(EventHandler.Find("AmmoSwitcher"));

	AS.Gun_Invoker = mo;	
}

//Getters
static int Get_Ammo_Selected()
{
	AmmoSwitcher AS;
	AS = AmmoSwitcher(EventHandler.Find("AmmoSwitcher"));
	
	return AS.Ammo_Selected;
}




}


