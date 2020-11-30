quest <- {
	category =    "CHALLENGE"
	name =        "Палящая жара"
	description = "Дальше к югу воздух и климат становятся влажными и тропическими. Защитите себя от враждебного климата."
	description_when_completed = "Жара тебя больше не беспокоит."
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
					description = "Изобретите [GREEN]Ковбойскую шляпу[WHITE] или [GREEN]кубики льда[WHITE] ."
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
