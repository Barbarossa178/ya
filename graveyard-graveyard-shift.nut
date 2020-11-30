quest <- {
	category =    "SIDE_QUEST"
	name =        "Кладбищная смена"
	description = "Согласно записям на столе, хранителя кладбища пугали таинственные огни, исходящие из задней части кладбища.  Похоже, он запер ворота и [GREEN]закопал[WHITE] ключ на могиле с [GREEN]'самой большой надгробной плитой вокруг'[WHITE]."
	description_when_completed = "Ключ вставляется в замок, и с громким 'щелчком' вам открывается доступ дальше на кладбище."
	image =       "quests/quest-image.jpg"

	requirements = {
		crafted_recipes="SHOVEL"
	}

	phases = [
		{
			id = "DIG_UP_KEY"
			description = ""
			reward_xp = 500
			goals = [
						{
							/* This phase needs an interactives/buried_treasure with treasure_id corresponding with one below and key_id "GRAVEYARD_KEY" */
							id = "GOAL_0_FIND"
							description = "Найти ключ от кладбища"

							function OnCollectibleFound(category, id)
							{
								if (category == "KEYS" && id == "GRAVEYARD_KEY")
								{
									SetCurrentPhaseGoalCompleted(0);
								}
							}

							function CheckCompletion()
							{
								local bool = Game_IsCollectibleFound("KEYS","GRAVEYARD_KEY");
								if (bool == true)
								SetCurrentPhaseGoalCompleted(0);
							}
						}
					]
		}
		{
			id = "OPEN_THE_GATES"
			description = ""
			reward_xp = 1000
			goals = [
				{
					/* This phase needs two interactable, closed doors with id set with actor_id and actor_id_2 to be opened with a key found in earlier phase.*/
					id = "GOAL_1_OPEN"
					description = "Откройте ворота, ведущие к задней части кладбища."
					required_amount = 1
					actor_id = "GRAVEYARD_GATE_1"
					actor_id_2 = "GRAVEYARD_GATE_2"

					function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
					{
						if (interaction_id != "open")
						{
							return;
						}

						if (!Game_IsCollectibleFound("KEYS", "GRAVEYARD_KEY"))
						{
							return;
						}

						local so_1 = StageObject_GetById(actor_id);
						local so_2 = StageObject_GetById(actor_id_2);
						if (so_1 == interactive_actor || so_2 == interactive_actor)
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
