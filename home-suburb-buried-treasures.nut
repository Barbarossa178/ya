quest <- {
	category =    "SIDE_QUEST"
	name =        "Зарытые сокровища"
	description = "Выкопайте тайники на карте."
	description_when_completed = "Вас мучает вопрос, есть ли еще скрытые сокровища, такие как эти."
	image =       "quests/quest-image.jpg"

	more_info_button_text = "Show The Letter"

	requirements = {
		crafted_recipes = "SHOVEL"
	}

	phases = [
		{
			id = "PHASE_0"
			reward_xp = 1500

			goals = [
				{
					id = "GOAL_0_0"
					description = "Выкопать сокровища"
					required_amount = 2
					treasure_id_prefix = "CAPERNAUM."

					function OnInitialize()
					{
						required_amount = Game_GetNumberOfCollectiblesInCategoryWithPrefix("BURIED_TREASURES", treasure_id_prefix);
						CheckProgress();
					}

					function CheckProgress()
					{
						local old_num = GetPersistentInteger("num_found", 0);
						local num = Game_GetNumberOfCollectiblesInCategoryFoundWithPrefix("BURIED_TREASURES", treasure_id_prefix);
						SetPersistentInteger("num_found", num);
						if (num >= this.required_amount)
							SetCurrentPhaseGoalCompleted(0);
					}

					function OnFoundNewTreasure(treasure_id)
					{
						if (!string_starts_with(treasure_id, treasure_id_prefix))
							return;
						CheckProgress();
					}

					function OnCommand(command)
					{
						CheckProgress();
						local command_word = Command_GetCommandWordAsString(command);
						NX_Print("Got command " + command_word);
						if (command_word == "dig")
						{
							local kvs = Command_GetKeyValueStore(command);
							local treasure_id = KeyValueStore_GetKeyValueAsString(kvs, "treasure_id");
							if (treasure_id == null)
								return;
							local current_phase_index = Game_GetQuestPhaseIndex(quest_id);
							OnFoundNewTreasure(treasure_id);
						}
					}

					function GetProgressText()
					{
						local num = GetPersistentInteger("num_found", 0);
						return num + "/" + this.required_amount;
					}
				 }
			]
		}
	]
}

function OnMoreInfoButtonClick()
{
	UI_PushScreen("QuestHomeSuburbBuriedTreasures");
}
