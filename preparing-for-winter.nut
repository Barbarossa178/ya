quest <- {
	category =    "CHALLENGE"
	name =        "Preparing for Winter"
	description = "Air gets colder and there is snow all around. Invent something that will keep you warm."
	description_when_completed = "Although the air never gets warmer, your body is now protected against the elements."
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
					id = "WINTER_GEAR"
					description = "Invent a [GREEN]Fur Hat[WHITE] or a [GREEN]Hot Water Bottle[WHITE] ."
					function OnInitialize()
					{
						Game_SetRecipeUnlocked("FUR_HAT", true);
						Game_SetRecipeUnlocked("HOT_WATER_BOTTLE", true);
						CheckProgress();
					}
					function OnUpdate(tdelta)
					{
						CheckProgress();
					}
					function CheckProgress()
					{
						if (Game_IsRecipeCrafted("FUR_HAT") || Game_IsRecipeCrafted("HOT_WATER_BOTTLE"))
							SetCurrentPhaseGoalCompletedById(id);
					}
				}	
			]
		}
	]
}
