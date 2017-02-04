
----------------------------------------------------------------------------------------------------

local castPhaseDesire = 0;
local castJauntDesire = 0;
local castCoilDesire = 0;
local castSilenceDesire = 0;
local castOrbDesire = 0;
local castBlinkInitDesire = 0; 
local castForceEnemyDesire = 0;

----------------------------------------------------------------------------------------------------

function AbilityLevelUpThink()    
    --print(GetBot():GetUnitName())
    if GetGameState() ~= GAME_STATE_GAME_IN_PROGRESS and
        GetGameState() ~= GAME_STATE_PRE_GAME
    then 
        return
    end
    local npcBot = GetBot()
    
    local refraction = npcBot:GetAbilityByName( "templar_assassin_refraction" )
    local meld = npcBot:GetAbilityByName( "templar_assassin_meld" )
    local PsiBlades = npcBot:GetAbilityByName( "templar_assassin_psi_blades" )
    local PsiTrap = npcBot:GetAbilityByName( "templar_assassin_psionic_trap" )

    -- code to level your bots skills here
    if npcBot:GetAbilityPoints() > 0 then
		if refraction:CanAbilityBeUpgraded() then
		    npcBot:Action_LevelAbility("templar_assassin_refraction")
		end
		if meld:CanAbilityBeUpgraded() then
		    npcBot:Action_LevelAbility("templar_assassin_meld")
		end
		if PsiBlades:CanAbilityBeUpgraded() then
		    npcBot:Action_LevelAbility("templar_assassin_psi_blades")
		end
		if PsiTrap:CanAbilityBeUpgraded() then
		    npcBot:Action_LevelAbility("templar_assassin_psionic_trap")
		end
	end
end


----------------------------------------------------------------------------------------------------

function AbilityUsageThink()
	local npcBot = GetBot();
	local sideOfMap = 0

	-- quit if we're already using an ability
	if ( npcBot:IsUsingAbility() ) then return end;

	abilityRefraction = npcBot:GetAbilityByName( "templar_assassin_refraction" )
	abilityPsiTrap = npcBot:GetAbilityByName("templar_assassin_psionic_trap")
	
	local castRefractionDesire = ConsiderRefraction();
	local castPsiTrapDesire, castPsiTrapLocation = ConsiderPsiTrap();

	local highestDesire = castRefractionDesire;
	local desiredSkill = 1;

	if ( castPsiTrapDesire > highestDesire) 
		then
			highestDesire = castPsiTrapDesire;
			desiredSkill = 2;
	end

	if highestDesire == 0 then return; -- no skill usage
    elseif desiredSkill == 1 then 
		npcBot:Action_UseAbility( abilityRefraction );
    elseif desiredSkill == 2 then 
		npcBot:Action_UseAbilityOnLocation( abilityPsiTrap, castPsiTrapLocation);
	end	

end

----------------------------------------------------------------------------------------------------

function ConsiderRefraction()

	local npcBot = GetBot()

	-- Make sure it's castable
	if ( not abilityRefraction:IsFullyCastable() ) 
	then 
		return BOT_ACTION_DESIRE_NONE
	end

	-- Example of how to pull data from skill using npc_abilities.txt
	local nInstances = abilityRefraction:GetSpecialValueInt( "instances" );

	if npcBot:HasModifier( "modifier_templar_assassin_refraction_absorb" ) or
		npcBot:HasModifier( "modifier_templar_assassin_refraction_damage" )
	then
		return BOT_ACTION_DESIRE_NONE
	end


	return BOT_ACTION_DESIRE_HIGH
end

----------------------------------------------------------------------------------------------------

function ConsiderPsiTrap()

	local npcBot = GetBot()

	-- Make sure it's castable
	if ( not abilityPsiTrap:IsFullyCastable() ) then 
		return BOT_ACTION_DESIRE_NONE
	end

	local tableNearbyEnemyHeroes = npcBot:GetNearbyHeroes( 1300, true, BOT_MODE_NONE)
	for _,v in pairs(tableNearbyEnemyHeroes) do
		if v:GetHealth() < ( v:GetMaxHealth() * .5 ) then
			return BOT_ACTION_DESIRE_HIGH, v:GetLocation()
		end
	end

	return BOT_ACTION_DESIRE_NONE, Vector(0,0,0);

end
