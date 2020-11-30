quest <- {
	category =    "CHALLENGE"
	name =        "Prison Break-In"
	description = "The gate that leads further into the prison has been locked. [GREEN]Search for the key[WHITE] around other parts of the building."
	description_when_completed = "The gate is open, but eerie sounds reverberate around the barren walls."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 1000
			goals = [
				{
					/* This phase needs an interactable object with id set with actor_id */
					id = "SEARCH_THE_PRISON"
					description = "Search the prison admin wing for key"
					actor_id = "PRISON_KEY_INFO"
					required_amount = 1

					function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
					{
						if (StageObject_GetId(interactive_actor) == actor_id && interaction_id == "activate")
						{
							local num = GetPersistentInteger("num_info_found", 0) + 1;
							SetPersistentInteger("num_info_found", num);
							if (num >= this.required_amount)
							{
								SetCurrentPhaseGoalCompletedById(id);

							}
						}
					}

					function OnInitialize()
					{
						if (Game_IsCollectibleFound("KEYS", "PRISON_KEY"))
						{
							SetCurrentPhaseGoalCompletedById(id);
						}
					}
				}
			]
		}
		{
			id = "PHASE_1"
			description = ""
			reward_xp = 1500
			goals = [
				{
					/* This phase needs a location marker with a location_id that corresponds with quest_location*/
					id = "GO_TO_POLICE_STATION"
					description = "Travel to [ORANGE]Curtisfield North[WHITE]."
					quest_location = "TOWN_8"

					function OnEnterLocation(location_id, new_location)
					{
						if (location_id == quest_location)
							SetCurrentPhaseGoalCompletedById(id);

					}

					function OnInitialize()
					{
						if (Game_IsCollectibleFound("KEYS", "PRISON_KEY"))
						{
							SetCurrentPhaseGoalCompletedById(id);
						}
					}
				}
			]
		}
		{
			id = "PHASE_2"
			description = ""
			reward_xp = 1750
			goals = [
				{
					/* This phase needs an interactable object with an id that corresponds with actor_id */
					id = "FIND_THE_KEY"
					description = "[GREEN]Search[WHITE] for the key inside [GREEN]police station[WHITE]."
					actor_id = "PRISON_KEY_LOC"
					quest_marker_stage_object_id = "PRISON_KEY_LOC"

					function OnCollectibleFound(category, id)
					{
						if (category == "KEYS" && id == "PRISON_KEY")
						{
							SetCurrentPhaseGoalCompleted(0);
						}
					}

					function OnInitialize()
					{
						if (Game_IsCollectibleFound("KEYS", "PRISON_KEY"))
						{
							SetCurrentPhaseGoalCompletedById(id);
						}
					}
				}
			]
		}
		{
			id = "PHASE_3"
			description = ""
			reward_xp = 2500
			goals = [
				{
					/* This phase needs one interactable, closed door with id set with actor_id to be opened with a set key*/
					id = "GOAL_1_OPEN"
					description = "Open the gate back at prison."
					required_amount = 1
					actor_id = "PRISON_GATE_1"

					function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
					{
						if (interaction_id != "open")
						{
							return;
						}

						if (!Game_IsCollectibleFound("KEYS", "PRISON_KEY"))
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
								SetCurrentPhaseGoalCompleted(0);
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