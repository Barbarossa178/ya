quest <- {
	category =    "TEMPORAL_CHALLENGE"
	name =        "Газонокосильщик"
	description = "Поле кишит бывшими людьми. Пришло время превратить их в удобрения."
	description_when_completed = "Природа позаботится об этой проблеме сейчас."
	image =       "quests/quest-image.jpg"
	time_limit =  75.0

	requirements = {
		xp_level = 7
	}

	phases = [
		{
			id = "PHASE_0"
			reward_xp = 2000
			goals = [
				{
					id = "KILL"
					description = "Убить [VAR.required_amount] бывших людей."
					actor_type_id_0 = "actors/enemies/ex-human-female-melee.xml"
					actor_type_id_1 = "actors/enemies/ex-human-male-melee.xml"
					actor_type_id_2 = "actors/enemies/ex-human-puker.xml"
					required_amount = 6

					function OnInitialize()
					{
					}

					function OnActorStartDying(actor)
					{
						if (!StageObject_HasTag(actor, "QUEST_TARGET"))
							return;

						local destroyed_actor_type = Actor_GetActorType(actor);
						if (destroyed_actor_type == this.actor_type_id_0 ||
							destroyed_actor_type == this.actor_type_id_1 ||
							destroyed_actor_type == this.actor_type_id_2)
						{
							local num = GetPersistentInteger("num_destroyed", 0) + 1;
							SetPersistentInteger("num_destroyed", num);
							if (num >= this.required_amount)
								SetCurrentPhaseGoalCompletedById(id);
						}
					}

					function GetProgressText()
					{
						local num = GetPersistentInteger("num_destroyed", 0);
						return num + "/" + this.required_amount;
					}
				}
				{
					id = "TIME"
					description = "Закончить за [VAR.temporal_challenge_time_limit] секунд."
					time_limited = true
				}
			]
		}
	]
}

