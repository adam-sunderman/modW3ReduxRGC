enum EControlScheme
{
	ECS_DefaultRGC = 0,
	ECS_ColorCoded = 1,
	ECS_GamepadPlusInspired = 2
}

enum EDefaultQuickUse
{
	EDQU_Inventory = 0,
	EDQU_Potions = 1
}

function RGCConfigIntToControlScheme(csConfigVal : int) : EControlScheme
{
	switch( csConfigVal )
	{
		case 0:
			return ECS_DefaultRGC;
		case 1:
			return ECS_ColorCoded;
		case 2:
			return ECS_GamepadPlusInspired;
	}
	
	return ECS_DefaultRGC;
}

function RGCConfigGetControlScheme() : EControlScheme
{
	var cfgVal : int;
	cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('w3ReduxRGC', 'virtual_w3ReduxRGCControlScheme'));
	
	return RGCConfigIntToControlScheme(cfgVal);
}

function RGCConfigGetDefaultQuickUse() : EDefaultQuickUse
{
	var cfgVal : int;
	cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('w3ReduxRGC', 'virtual_w3ReduxRGCDefaultInventory'));
	switch( cfgVal )
	{
		case 0:
			return EDQU_Inventory;
		case 1:
			return EDQU_Potions;
	}
	return EDQU_Inventory;
}

function RGCConfigPeriodic() : void
{
	var cfgVal : int;
	var cs : EControlScheme;
	var input : W3ReduxRGCInput;
	input = (W3ReduxRGCInput) GetWitcherPlayer().GetInputHandler();
	cfgVal = StringToInt(theGame.GetInGameConfigWrapper().GetVarValue('w3ReduxRGC', 'virtual_w3ReduxRGCControlScheme'));
	cs = RGCConfigIntToControlScheme(cfgVal);
	
	if(cs != input.currentScheme)
	{
		input.updateControlScheme(cs);
	}
}