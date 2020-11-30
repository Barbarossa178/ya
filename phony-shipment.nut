quest <- {
	category =    "SIDE_QUEST"
	name =        "Phony Shipment"
	description = "There is a note in the dossier: 'Hey guys, it seems I forgot the key in the pocket of my pants. My wife must've put them in the [GREEN]washing machine[WHITE] so it seems the shipment will be late. Sorry!'"
	description_when_completed = "The key opened a door into a storage full of materials. One man's misfortune seems to be another man's fortune."
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
							description = "Find the storage key"

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
					description = "Open the storage door."
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
