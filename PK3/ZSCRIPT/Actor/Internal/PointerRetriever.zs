/*
	Retrieves pointers from Actors.
*/

Class PointerRetriever : EventHandler
{
	Actor p_Actor;

	Static void Set_p_Actor(Actor mo)
	{
		PointerRetriever PR;
		PR = PointerRetriever(EventHandler.Find("PointerRetriever"));	
	
		PR.p_Actor = mo;
	}
	
	Static actor Get_p_Actor()
	{
		PointerRetriever PR;
		PR = PointerRetriever(EventHandler.Find("PointerRetriever"));	

		return PR.p_Actor;
	}
}