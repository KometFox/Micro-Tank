/*
Dummy EventHandler
*/
Class DummyEH : EventHandler
{

override bool InputProcess(InputEvent e)
{
	if (e.Type == InputEvent.Type_KeyDown)
	{
		SendNetworkEvent("DOWN", e.KeyScan);	
	}
	return false;
}

}