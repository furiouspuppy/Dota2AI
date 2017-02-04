
local bot = "npc_dota_hero_templar_assassin"
local pick = true

function Think()
	if pick then
		for i=0,7 do
			SelectHero(i,bot);
		end
		pick = false
	end
end