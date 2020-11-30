quest <- {
	category =    "CHALLENGE"
	name =        "Барьер для входа"
	description = "Большая часть комплекса эвакуационного центра находится под блокировкой, поэтому мне нужно найти ключ, чтобы получить доступ. Возможно, я смогу найти подсказки из офисного здания на месте."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 250
			goals = [
				{
					/* This phase needs an interactable object with id set with actor_id */
					id = "GOAL_0_FIND"
					description = "Ищите подсказки на базе."
					actor_id = "EVAC_SITE_KEY_INFO"
					required_amount = 1
					
					function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
					{
						local so_1 = StageObject_GetById(actor_id);
						if (so_1 == interactive_actor)
						{
							local num = GetPersistentInteger("num_info_found", 0) + 1;
							SetPersistentInteger("num_info_found", num);
							if (num >= this.required_amount)
							{
								SetCurrentPhaseGoalCompletedById(id);
							}
						}
					}

					function GetProgressText()
					{
						local num = GetPersistentInteger("num_info_found", 0);
						return num + "/" + this.required_amount;
					}
				}
			]
		}
		{
			id = "PHASE_1"
			description = "Похоже, единственный оставшийся на острове запасной ключ находится в доме бывшего менеджера. Раньше он жил далеко на севере от места эвакуации."
			reward_xp = 250
			goals = [
				{
					/* This phase needs a location marker with a location_id that corresponds with quest_location*/
					id = "GO"
					description = "Найдите город [GREEN]Бернсли[WHITE]."
					quest_location = "TOWN_5"

					function OnEnterLocation(location_id, new_location)
					{
						if (location_id == quest_location)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
			]
		}
		{	
			id = "PHASE_2"
			description = ""
			reward_xp = 250
			goals = [
				{
					/* This phase needs an interactable object with an id that corresponds with actor_id */
					id = "FIND"
					description = "[GREEN]Ищите[WHITE]  ключ в Бернсли."
					actor_id = "EVAC_SITE_KEY_LOC"
					required_amount = 1

					function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
					{
						local so_1 = StageObject_GetById(actor_id);
						if (so_1 == interactive_actor)
						{
							local num = GetPersistentInteger("num_found", 0) + 1;
							SetPersistentInteger("num_found", num);
							if (num >= this.required_amount)
							{
								SetCurrentPhaseGoalCompletedById(id);
							}
						}
					}
				}
			]
		}
		{
			id = "PHASE_3"
			description = ""
			reward_xp = 250
			goals = [
				{
					/* This phase needs two interactable, closed doors with id set with actor_id and actor_id_2 to be opened with a set key*/
					id = "GOAL_1_OPEN"
					description = "Откройте металлические ворота на месте эвакуации."
					required_amount = 2
					actor_id = "EVAC_SITE_GATE_1"
					actor_id_2 = "EVAC_SITE_GATE_2"

					function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
					{
						if (interaction_id != "open")
						{
							return;
						}

						if (!Game_IsCollectibleFound("KEYS", "EVAC_SITE_KEY"))
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
