quest <- {
	category =    "CHALLENGE"
	name =        "Cтановится сильнее"
	description = "Этот мир очень опасен. Чтобы выжить, вам нужно еще больше экипироваться."
	description_when_completed = "Пока этих мер будет достаточно."
	image =       "quests/quest-image.jpg"

	requirements = {
		quest = "quests/home-suburb-basic-necessities.nut"
	}

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 1500
			goals = [

				{
					id = "COOKING_POT"
					description = "Изобрести [GREEN]Кастрюлю[WHITE]."
					function OnInitialize()
					{
						CheckProgress();
					}
					function OnUpdate(tdelta)
					{
						CheckProgress();
					}
					function CheckProgress()
					{
						if (Game_IsRecipeCrafted("COOKING_POT"))
							SetCurrentPhaseGoalCompletedById(id);
					}
				},


				{
					id = "COOK_RECIPE"
					description = "Приготовить любую еду."

					function OnInitialize()
					{
						CheckProgress();
					}
					
					function OnCraftedRecipe(recipe_id)
					{
						CheckProgress();
					}

					function OnUpdate(tdelta)
					{
						//CheckProgress();
					}

					function CheckProgress()
					{
						local num = Game_GetNumberOfRecipesCraftedInCategory("COOKING");
						if (num >= 1)
							SetCurrentPhaseGoalCompletedById(id);
					}
				},

				{
					id = "NEW_WEAPON"
					description = "Создать [GREEN]Метательные ножи[WHITE]."
					function OnInitialize()
					{
						CheckProgress();
					}
					function OnUpdate(tdelta)
					{
						CheckProgress();
					}
					function CheckProgress()
					{
						if (Game_IsRecipeCrafted("THROWING_KNIVES"))
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
			]
		}
	]
}

function OnQuestAccepted()
{
	if (!Game_IsRecipeCrafted("COOKING_POT"))
		Game_SetRecipeTracked("COOKING_POT", true);
	if (!Game_IsRecipeCrafted("THROWING_KNIVES"))
		Game_SetRecipeTracked("THROWING_KNIVES", true);
}

