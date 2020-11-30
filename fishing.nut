quest <- {
	category =    "SIDE_QUEST"
	name =        "Рыба, которая была здесь."
	description = "Рыба все равно должна быть безопасна для еды. Попробуйте поймать несколько для приготовления пищи."
	description_when_completed = "Рыбалка кажется вам второй натурой."
	image =       "quests/quest-image.jpg"

	/*requirements = {
		crafted_recipes="FISHING_ROD"
	}*/

	phases = [
		{
			id = "FISHING_0"
			description = ""
			reward_xp = 2000
			goals = [

				{
					id = "FISHING_ROD"
					description = "Изобрести и создать[GREEN]Удочку[WHITE]."

					function OnInitialize()
					{
						CheckProgress();
						Game_SetRecipeUnlocked("FISHING_ROD", true);
					}

					function OnUpdate(tdelta)
					{
						CheckProgress();
					}

					function CheckProgress()
					{
						if (Game_IsRecipeUnlocked("FISHING_ROD") && Game_IsRecipeCrafted("FISHING_ROD"))
							SetCurrentPhaseGoalCompletedById(id);
					}
				}

				{
					id = "FISHING_0_0"
					description = "Поймать [VAR.required_fish] рыбу."
					required_fish = 3

					function OnCaughtFish(fish_material_id)
					{
						if (!string_starts_with(fish_material_id, "FISH_"))
							return;
							
						local num_caught_fish = GetPersistentInteger("num_caught_fish", 0) + 1;
						SetPersistentInteger("num_caught_fish", num_caught_fish);

						if (num_caught_fish >= required_fish)
							SetCurrentPhaseGoalCompletedById(id);
					}

					function GetProgressText()
					{
						local num_caught_fish = GetPersistentInteger("num_caught_fish", 0);
						return num_caught_fish + "/" + required_fish;
					}
				}
			]
		}
	]
}
