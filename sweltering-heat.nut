quest <- {
	category =    "CHALLENGE"
	name =        "Sweltering Heat"
	description = "Further down south the air and overall climate get damp and tropical. Protect yourself against the hostile climate."
	description_when_completed = "The heat does not falter you any more."
	image =       "quests/quest-image.jpg"

	requirements = {
		xp_level = 13
	}

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 5000

			goals = [
				{
					id = "TROPICAL_GEAR"
					description = "Invent a [GREEN]Cowboy Hat[WHITE] or an [GREEN]Ice Brick[WHITE] ."
					function OnInitialize()
					{
						Game_SetRecipeUnlocked("COWBOY_HAT", true);
						Game_SetRecipeUnlocked("ICE_BRICK", true);
						CheckProgress();
					}
					function OnUpdate(tdelta)
					{
						CheckProgress();
					}
					function CheckProgress()
					{
						if (Game_IsRecipeCrafted("COWBOY_HAT") || Game_IsRecipeCrafted("ICE_BRICK"))
							SetCurrentPhaseGoalCompletedById(id);
					}
				}	
			]
		}
	]
}
