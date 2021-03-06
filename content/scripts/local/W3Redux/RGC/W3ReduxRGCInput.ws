/**
 * extension of CPlayerInput meant to compartmentalize the drastic changes W3ReduxRGC makes to playerInput.ws
 * with the purpose of easier merging of the file with other mods.
 *
 * This class explicitly alters the behavior of the following buttons:
 * A, B, X, Y, LB, RB, RT, DPAD UP, DPAD DOWN
 * Other mods that try to react to these inputs may not see the input at all!!!
 * It is recommended to not use any other control mods that make use of these buttons
 * Author: Adam Sunderman
 */
 
 class W3ReduxRGCInput extends CPlayerInput
 {
	var currentScheme : EControlScheme;
 
 	private function RGC_ClearRegistrations() : void
	{
		theInput.UnregisterListener( this, 'RGC_RealtimeModifier' );
		theInput.UnregisterListener( this, 'RGC_CastIgni' );
		theInput.UnregisterListener( this, 'RGC_CastAard' );
		theInput.UnregisterListener( this, 'RGC_CastQuen' );
		theInput.UnregisterListener( this, 'RGC_CastYrden' );
		theInput.UnregisterListener( this, 'RGC_CastAxii' );
		theInput.UnregisterListener( this, 'RGC_CrossBow' );
		theInput.UnregisterListener( this, 'RGC_CrossBowHold' );
		theInput.UnregisterListener( this, 'RGC_EquipQuickItem1' );
		theInput.UnregisterListener( this, 'RGC_EquipBomb1' );
		theInput.UnregisterListener( this, 'RGC_QuickItemUpperHold' );
		theInput.UnregisterListener( this, 'RGC_BombLowerHold' );
	}
	
	private function RGC_RegisterSchemeDefaultRGC() : void
	{
		RGC_ClearRegistrations();
	
		theInput.RegisterListener( this, 'OnRGCRealtimeModifier', 'RGC_RealtimeModifier' );
		theInput.RegisterListener( this, 'OnRGCCastIgni', 'RGC_CastIgni' );
		theInput.RegisterListener( this, 'OnRGCCastAard', 'RGC_CastAard' );
		theInput.RegisterListener( this, 'OnRGCCastQuen', 'RGC_CastQuen' );
		theInput.RegisterListener( this, 'OnRGCCastYrden', 'RGC_CastYrden' );
		theInput.RegisterListener( this, 'OnRGCCastAxii', 'RGC_CastAxii' );
		theInput.RegisterListener( this, 'OnRGCCrossBow', 'RGC_CrossBow' );
		theInput.RegisterListener( this, 'OnRGCCrossBowHold', 'RGC_CrossBowHold' );
		theInput.RegisterListener( this, 'OnRGCEquipQuickItem1', 'RGC_EquipQuickItem1' );
		theInput.RegisterListener( this, 'OnRGCEquipBomb1', 'RGC_EquipBomb1' );
		theInput.RegisterListener( this, 'OnRGCQuickItemUpperHold', 'RGC_QuickItemUpperHold' );
		theInput.RegisterListener( this, 'OnRGCBombLowerHold', 'RGC_BombLowerHold' );
	}
	
	private function RGC_RegisterSchemeColorCoded() : void
	{
		RGC_ClearRegistrations();
		
		theInput.RegisterListener( this, 'OnRGCRealtimeModifier', 'RGC_RealtimeModifier' );
		theInput.RegisterListener( this, 'OnRGCCastAard', 'RGC_CastIgni' );
		theInput.RegisterListener( this, 'OnRGCCastQuen', 'RGC_CastAard' );
		theInput.RegisterListener( this, 'OnRGCCastIgni', 'RGC_CastQuen' );
		theInput.RegisterListener( this, 'OnRGCCastYrden', 'RGC_CastYrden' );
		theInput.RegisterListener( this, 'OnRGCCastAxii', 'RGC_CastAxii' );
		theInput.RegisterListener( this, 'OnRGCCrossBow', 'RGC_CrossBow' );
		theInput.RegisterListener( this, 'OnRGCCrossBowHold', 'RGC_CrossBowHold' );
		theInput.RegisterListener( this, 'OnRGCEquipQuickItem1', 'RGC_EquipQuickItem1' );
		theInput.RegisterListener( this, 'OnRGCEquipBomb1', 'RGC_EquipBomb1' );
		theInput.RegisterListener( this, 'OnRGCQuickItemUpperHold', 'RGC_QuickItemUpperHold' );
		theInput.RegisterListener( this, 'OnRGCBombLowerHold', 'RGC_BombLowerHold' );
	}
	
	private function RGC_RegisterSchemeGPI() : void
	{
		RGC_ClearRegistrations();
		
		theInput.RegisterListener( this, 'OnRGCCastYrden', 'RGC_RealtimeModifier' );
		theInput.RegisterListener( this, 'OnRGCCastIgni', 'RGC_RealtimeModifier' );
		theInput.RegisterListener( this, 'OnRGCCastAard', 'RGC_CastIgni' );
		theInput.RegisterListener( this, 'OnRGCCastQuen', 'RGC_CastAard' );
		theInput.RegisterListener( this, 'OnRGCCastAxii', 'RGC_CastQuen' );
		theInput.RegisterListener( this, 'OnRGCCastAxii', 'RGC_CastAxii' );
		theInput.RegisterListener( this, 'OnRGCRealtimeModifier', 'RGC_CrossBow' );
		theInput.RegisterListener( this, 'OnRGCEquipQuickItem1', 'RGC_EquipQuickItem1' );
		theInput.RegisterListener( this, 'OnRGCEquipBomb1', 'RGC_EquipBomb1' );
		theInput.RegisterListener( this, 'OnRGCQuickItemUpperHold', 'RGC_QuickItemUpperHold' );
		theInput.RegisterListener( this, 'OnRGCBombLowerHold', 'RGC_BombLowerHold' );
	}
 
	public function updateControlScheme(cs : EControlScheme)
	{	
		switch(cs)
		{
			case ECS_DefaultRGC:
				RGC_RegisterSchemeDefaultRGC();
				break;
			case ECS_ColorCoded:
				RGC_RegisterSchemeColorCoded();
				break;
			case ECS_GamepadPlusInspired:
				RGC_RegisterSchemeGPI();
				break;
		}
		currentScheme = cs;
	}
 
	public function Initialize(isFromLoad : bool, optional previousInput : CPlayerInput)
	{
		//let Vanilla Input initialize with same parameters
		super.Initialize(isFromLoad, previousInput);
		
		//register listeners for new commands available in RGC
		updateControlScheme(RGCConfigGetControlScheme());
	}
	
	public function RGC_CastSign(sign : ESignType) : bool
	{
		//declare vars
		var signSkill : ESkill;

		//convert sign enumeration into actual Witcher Player skill
		signSkill = SignEnumToSkillEnum( sign );
		
		//validate skill is not undefined defined
		if( signSkill == S_SUndefined )
		{
			//Uh oh
			return false;
		}

		//immediately equip the desired sign
		GetWitcherPlayer().SetEquippedSign(sign);
		
		//can cast validation
		if( !IsActionAllowed(EIAB_Signs) )
		{
			thePlayer.DisplayActionDisallowedHudMessage(EIAB_Signs);
			return false;
		}
		if ( thePlayer.IsHoldingItemInLHand() && thePlayer.IsUsableItemLBlocked() )
		{
			thePlayer.DisplayActionDisallowedHudMessage(EIAB_Undefined, false, false, true);
			return false;
		}
		
		//skill validation
		if(!thePlayer.CanUseSkill(signSkill))
		{
			thePlayer.DisplayActionDisallowedHudMessage(EIAB_Signs, false, false, true);
			return false;
		}
		if(!thePlayer.HasStaminaToUseSkill( signSkill, false ) )
		{
			thePlayer.SoundEvent("gui_no_stamina");
			return false;
		}

		//Validated. Cast Sign!
		thePlayer.SetupCombatAction( EBAT_CastSign, BS_Pressed );
		return true;
	}
	
	event OnRGCRealtimeModifier(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			GetWitcherPlayer().RGC_SetInRealtimeEquipCastMode(false);
			return false;
		}
	
		if(IsPressed(action))
		{
			//realtime modifier was just pressed. This flag is utilized by most events to allow realtime
			//sign casting and item selection without the radial menu
			GetWitcherPlayer().RGC_SetInRealtimeEquipCastMode(true);
		}
		else if(IsReleased(action))
		{
			//realtime modifier was just released. Back to default actions
			GetWitcherPlayer().RGC_SetInRealtimeEquipCastMode(false);
		}
	}
	
	event OnRGCCastIgni(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
	
		//must have realtime modifier active
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//make sure action is pressed
			if(IsPressed(action))
			{
				//cast igni
				RGC_CastSign(ST_Igni);
			}
		}
	}
	
	event OnRGCCastAard(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
	
		//must have realtime modifier active
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//make sure action is pressed
			if(IsPressed(action))
			{
				//cast aard
				RGC_CastSign(ST_Aard);
			}
		}
	}
	
	event OnRGCCastQuen(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
	
		//must have realtime modifier active
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//make sure action is pressed
			if(IsPressed(action))
			{
				//cast quen
				RGC_CastSign(ST_Quen);
			}
		}
	}
	
	event OnRGCCastYrden(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
			
		//must have realtime modifier active
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//make sure action is pressed
			if(IsPressed(action))
			{
				//cast Yrden
				RGC_CastSign(ST_Yrden);
			}
		}
	}
	
	event OnRGCCastAxii(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
	
		//must have realtime modifier active
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//make sure action is pressed
			if(IsPressed(action))
			{
				//cast Axii
				RGC_CastSign(ST_Axii);
			}
		}
	}
	
	event OnRGCCrossBow(action : SInputAction)
	{
		//NOTES: Used crossbow logic of OnCbtThrowItem as base
		var ret : bool;
		var itemId : SItemUniqueId;
	
		//On button press, select crossbow
		if(IsPressed(action))
		{
			GetWitcherPlayer().SelectQuickslotItem(EES_RangedWeapon);
		}

		//validation of player
		if(thePlayer.IsInAir() || thePlayer.GetWeaponHolster().IsOnTheMiddleOfHolstering())
		{
			return false;
		}
		if( thePlayer.IsSwimming() && !thePlayer.OnCheckDiving() && thePlayer.GetCurrentStateName() != 'AimThrow' )
		{
			return false;
		}

		//validation of item
		itemId = thePlayer.GetSelectedItemId();
		if(!thePlayer.inv.IsIdValid(itemId) || !thePlayer.inv.IsItemCrossbow(itemId))
		{
			return false;
		}
		
		//crossbow button press logic
		if ( IsActionAllowed(EIAB_Crossbow) )
		{
			//on press
			if( IsPressed(action))
			{
				//are we ready to aim crossbow immediately?
				if ( thePlayer.IsHoldingItemInLHand() && !thePlayer.IsUsableItemLBlocked() )
				{
					//setup restore action to interact with crossbow when its available
					thePlayer.SetPlayerActionToRestore ( PATR_Crossbow );
					thePlayer.OnUseSelectedItem( true );
					ret = true;
				}
				else if ( thePlayer.GetBIsInputAllowed() && !thePlayer.IsCurrentlyUsingItemL() )
				{
					//initialize player to state aiming, send combat action to start state machines
					thePlayer.SetIsAimingCrossbow( true );
					thePlayer.SetupCombatAction( EBAT_ItemUse, BS_Pressed );
					ret = true;
				}
			}
			//on release
			else if(IsReleased(action))
			{
				if ( thePlayer.GetIsAimingCrossbow() && !thePlayer.IsCurrentlyUsingItemL() )
				{
					//send combat action Release to trigger onRelease statemachine flow
					//and reset player to not aiming state
					thePlayer.SetupCombatAction( EBAT_ItemUse, BS_Released );
					thePlayer.SetIsAimingCrossbow( false );
					thePlayer.SetThrowHold(false);
					ret = true;
				}
			}
		}
		else
		{
			if ( !thePlayer.IsInShallowWater() )
			{
				//can't use crossbow feedback
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_Crossbow);
			}
		}

		return ret;
	}
	
	event OnRGCCrossBowHold( action : SInputAction )
	{
		//NOTES: Used crossbow logic of OnCbtThrowItemHold as base
		var itemId : SItemUniqueId;

		//validation of player
		if(thePlayer.IsInAir() || thePlayer.GetWeaponHolster().IsOnTheMiddleOfHolstering() )
		{
			return false;
		}
		if( thePlayer.IsSwimming() && !thePlayer.OnCheckDiving() && thePlayer.GetCurrentStateName() != 'AimThrow' )
		{
			return false;
		}

		//validation of item
		itemId = thePlayer.GetSelectedItemId();
		if(!thePlayer.inv.IsIdValid(itemId) || !thePlayer.inv.IsItemCrossbow(itemId))
		{
			return false;
		}
		
		//validate press
		if(IsPressed(action))
		{
			if(!IsActionAllowed(EIAB_Crossbow))
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_Crossbow);
				return false;
			}
		}

		//on press
		if(IsPressed(action))
		{
			//set player state to throw hold
			thePlayer.SetThrowHold(true);
			return true;
		}
		else if(IsReleased(action) && thePlayer.IsThrowHold())
		{
			return true;
		}

		return false;
	}
	
	private var quickSelectHeld : bool;
	event OnRGCEquipQuickItem1(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
	
		//quickslot items are available while modifier is active
		if(RGC_IsQuickItemsInventory())
		{
			//validate quickslot selection
			if(!IsActionAllowed(EIAB_QuickSlots))
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_QuickSlots);
				return false;
			}

			//On press, set the held helper variable to false
			//Note: marked true in OnRGCEquipQuickItemUpperHold()
			if(IsPressed(action))
			{
				quickSelectHeld = false;
			}
			//if is released and was never held, select current quickslot upper
			else if(IsReleased(action) && !quickSelectHeld)
			{
				GetWitcherPlayer().RGC_SelectItem(GetWitcherPlayer().RGC_GetSelectedQuickSlotUpper());
				return true;
			}

			//no selection made
			return false;
		}
	}
	
	private var bombSelectHeld : bool;
	event OnRGCEquipBomb1(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}	

		//bomb items are available while modifier is active
		//quickslot items are available while modifier is active
		if(RGC_IsQuickItemsInventory())
		{
			//validate quickslot selection
			if(!IsActionAllowed(EIAB_QuickSlots))
			{
				thePlayer.DisplayActionDisallowedHudMessage(EIAB_QuickSlots);
				return false;
			}

			//On press, set the held helper variable to false
			//Note: marked true in OnRGCEquipBombLowerHold()
			if(IsPressed(action))
			{
				bombSelectHeld = false;
			}
			//if is released and was never held, select current bomb lower
			else if(IsReleased(action) && !bombSelectHeld)
			{
				GetWitcherPlayer().RGC_SelectItem(GetWitcherPlayer().RGC_GetSelectedBombSlotLower());
				return true;
			}

			return false;
		}
	}
	
	event OnRGCQuickItemUpperHold(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
	
		//quick item swapping is available while modifier is active
		//quickslot items are available while modifier is active
		if(RGC_IsQuickItemsInventory())
		{
			//don't swap if released
			if(IsReleased(action))
			{
				return false;
			}

			//mark held variable to true (disables unheld selection)
			//and flip selected quickslot item
			quickSelectHeld = true;
			GetWitcherPlayer().RGC_FlipSelectedQuickSlot();
			return true;
		}
	}
	
	event OnRGCBombLowerHold(action : SInputAction)
	{
		//RGC doesn't affect Ciri and is only applicable to gamepad users
		if(thePlayer.IsCiri() || !theInput.LastUsedGamepad())
		{
			return false;
		}
	
		//quick bomb swapping is available while modifier is active
		//quickslot items are available while modifier is active
		if(RGC_IsQuickItemsInventory())
		{
			//don't swap if released
			if(IsReleased(action))
			{
				return false;
			}

			//mark held variable to true (disables unheld selection)
			//and flip selected bomb item
			bombSelectHeld = true;
			GetWitcherPlayer().RGC_FlipSelectedBombSlot();
			return true;
		}
	}
	
	event OnCommSprint( action : SInputAction )
	{
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//does not occur while modifier is active
			return false;
		}
		
		//super handling of sprint input
		return super.OnCommSprint(action);
	}
	
	event OnCommDrinkpotionUpperHeld( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(!RGC_IsQuickItemsPotions())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
	
		return super.OnCommDrinkpotionUpperHeld(action);
	}
	
	event OnCommDrinkpotionLowerHeld( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(!RGC_IsQuickItemsPotions())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCommDrinkpotionLowerHeld(action);
	}
	
	event OnCommDrinkPotion1( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(!RGC_IsQuickItemsPotions())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCommDrinkPotion1(action);
	}
	
	event OnCommDrinkPotion2( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(!RGC_IsQuickItemsPotions())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCommDrinkPotion2(action);
	}
	
	event OnCbtAttackLight( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCbtAttackLight(action);
	}
	
	event OnCbtAttackHeavy( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
	
		return super.OnCbtAttackHeavy(action);
	}
	
	event OnCbtSpecialAttackLight( action : SInputAction )
	{
		//modW3ReduxRGC++
		if ( GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode() )
		{
			//don't do attacks while casting
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCbtSpecialAttackLight(action);
	}
	
	event OnCbtSpecialAttackHeavy( action : SInputAction )
	{
		//modW3ReduxRGC++
		if ( GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode() )
		{
			//don't do attacks while casting
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCbtSpecialAttackHeavy(action);
	}
	
	event OnCbtDodge( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCbtDodge(action);
	}
	
	event OnCbtRoll( action : SInputAction )
	{
		//modW3ReduxRGC++
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCbtRoll(action);
	}
	
	event OnCastSign( action : SInputAction )
	{
		var signSkill : ESkill;

		//modW3ReduxRGC++
		//there is no sign selection in RGC, thus casting a selected sign isn't a necessary action
		return false;
		//modW3ReduxRGC--
	}
	
	event OnCbtThrowItem( action : SInputAction )
	{
		var isUsableItem, isCrossbow, isBomb, ret : bool;
		var itemId : SItemUniqueId;
		
		//modW3ReduxRGC++
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//does not occur while modifier is active
			return false;
		}
	
		//make sure button is pressed before selecting non-crossbow item
		if(IsPressed(action))
		{
			thePlayer.OnRangedForceHolster(true);
			GetWitcherPlayer().SelectQuickslotItem(GetWitcherPlayer().RGC_GetLastUsedItem());
		}
		//modW3ReduxRGC--

		if(thePlayer.IsInAir() || thePlayer.GetWeaponHolster().IsOnTheMiddleOfHolstering())
			return false;

		if( thePlayer.IsSwimming() && !thePlayer.OnCheckDiving() && thePlayer.GetCurrentStateName() != 'AimThrow' )
			return false;

		itemId = thePlayer.GetSelectedItemId();

		if(!thePlayer.inv.IsIdValid(itemId))
			return false;

		isCrossbow = thePlayer.inv.IsItemCrossbow(itemId);
		if(!isCrossbow)
		{
			isBomb = thePlayer.inv.IsItemBomb(itemId);
			if(!isBomb)
			{
				isUsableItem = true;
			}
		}

		//modW3ReduxRGC++
		if( isCrossbow )
		{
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCbtThrowItem(action);
	}
	
	event OnCbtThrowItemHold( action : SInputAction )
	{
		var isBomb, isCrossbow, isUsableItem : bool;
		var itemId : SItemUniqueId;

		//modW3ReduxRGC++
		if(GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode())
		{
			//does not occur while modifier is active
			return false;
		}
		//modW3ReduxRGC--

		if(thePlayer.IsInAir() || thePlayer.GetWeaponHolster().IsOnTheMiddleOfHolstering() )
			return false;

		if( thePlayer.IsSwimming() && !thePlayer.OnCheckDiving() && thePlayer.GetCurrentStateName() != 'AimThrow' )
			return false;

		itemId = thePlayer.GetSelectedItemId();

		if(!thePlayer.inv.IsIdValid(itemId))
			return false;

		isCrossbow = thePlayer.inv.IsItemCrossbow(itemId);
		
		//modW3ReduxRGC++
		if( isCrossbow )
		{
			return false;
		}
		//modW3ReduxRGC--
		
		return super.OnCbtThrowItemHold(action);
	}
	
	//helpers
	public function RGC_IsQuickItemsInventory() : bool
	{
		if((GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode() && RGCConfigGetDefaultQuickUse() == EDQU_Potions) ||
			(!GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode() && RGCConfigGetDefaultQuickUse() == EDQU_Inventory))
		{
			return true;
		}
		
		return false;
	}
	
	public function RGC_IsQuickItemsPotions() : bool
	{
		if((GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode() && RGCConfigGetDefaultQuickUse() == EDQU_Inventory) ||
			(!GetWitcherPlayer().RGC_IsInRealtimeEquipCastMode() && RGCConfigGetDefaultQuickUse() == EDQU_Potions))
		{
			return true;
		}
		
		return false;
	}
 }