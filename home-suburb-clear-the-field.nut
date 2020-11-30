quest <- {
	category =    "TEMPORAL_CHALLENGE"
	name =        "Быстрый баскетбол"
	description = "Очистить баскетбольное поле от врагов за 60 секунд."
	description_when_completed = "На баскетбольной площадке снова тихо."
	image =       "quests/quest-image.jpg"
	time_limit =  60.0

	requirements = {
		xp_level = 5
	}

	phases = [
		{
			id = "PHASE_0"
			reward_xp = 1500
			goals = [
				{
					id = "KILL"
					description = "Убить [VAR.required_amount] бывших людей."
					actor_type_id_0 = "actors/enemies/ex-human-female-melee.xml"
					actor_type_id_1 = "actors/enemies/ex-human-male-melee.xml"
					required_amount = 5

					function OnInitialize()
					{
					}

					function OnActorStartDying(actor)
					{
						if (!StageObject_HasTag(actor, "QUEST_TARGET"))
							return;

						local destroyed_actor_type = Actor_GetActorType(actor);
						if (destroyed_actor_type == this.actor_type_id_0 ||
							destroyed_actor_type == this.actor_type_id_1)
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

