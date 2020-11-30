quest <- {
	category =    "CHALLENGE"
	name =        "Подготовка к зиме"
	description = "Воздух становится холоднее, а вокруг - снег. Придумайте что-нибудь, что согреет вас."
	description_when_completed = "Хотя температура воздуха не поднимается, ваше тело теперь защищено от воздействия стихии."
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
					description = "Изобрести [GREEN]меховую шапку[WHITE] или [GREEN]бутылку горячей воды [WHITE] ."
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
