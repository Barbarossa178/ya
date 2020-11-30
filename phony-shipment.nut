quest <- {
	category =    "SIDE_QUEST"
	name =        "Фальшивая пересылка"
	description = "В досье есть записка: 'Эй, ребята, кажется, я забыл ключ в кармане брюк. Моя жена, должно быть, положила их в [ЗЕЛЕНУЮ]стиральную машину[БЕЛЫЙ], так что, похоже, посылка опоздает'. Извините!'"
	description_when_completed = "Ключ открыл дверь на склад, полный материалов. Судя по всему, несчастье одного человека - это удача для другого."
	image =       "quests/quest-image.jpg"

	requirements = {
		xp_level = 6
	}

	phases = [
		{
			id = "FIND_KEY"
			description = ""
			reward_xp = 750
			goals = [
						{
							/* This phase needs an interactives/buried_treasure with treasure_id corresponding with one below and key_id "GRAVEYARD_KEY" */
							id = "GOAL_0_FIND"
							description = "Найдите ключ от хранилища"

							function OnCollectibleFound(category, id)
							{
								if (category == "KEYS" && id == "STORAGE_KEY_1")
								{
									SetCurrentPhaseGoalCompleted(0);
								}
							}

							function OnInitialize()
							{
								if (Game_IsCollectibleFound("KEYS", "STORAGE_KEY_1"))
								{
									SetCurrentPhaseGoalCompletedById(id);
								}
							}
						}
					]
		}
		{
			id = "OPEN_THE_DOOR"
			description = ""
			reward_xp = 1200
			goals = [
				{
					/* This phase needs two interactable, closed doors with id set with actor_id and actor_id_2 to be opened with a key found in earlier phase.*/
					id = "GOAL_1_OPEN"
					description = "Откройте дверь хранилища."
					required_amount = 1
					actor_id = "WAYWARD_STORAGE_DOOR"

					function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
					{
						if (interaction_id != "open")
						{
							return;
						}

						if (!Game_IsCollectibleFound("KEYS", "STORAGE_KEY_1"))
						{
							return;
						}

						local so_1 = StageObject_GetById(actor_id);
						if (so_1 == interactive_actor)
						{
							local num = GetPersistentInteger("num_opened", 0) + 1;
							SetPersistentInteger("num_opened", num);
							if (num >= this.required_amount)
							{
								SetCurrentPhaseGoalCompletedById(id);
							}
						}
					}

					function GetProgressText()
					{
						local num = GetPersistentInteger("num_opened", 0);
						return num + "/" + this.required_amount;
					}
				}
			]
		}
	]
}
