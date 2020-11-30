quest <- {
	category =    "TEMPORAL_CHALLENGE"
	name =        "Мор и Чума"
	description = "Мерзкие звуки усиливаются вокруг тебя. Бывшие люди - не единственная опасность в этих местах."
	description_when_completed = "Зловоние кислоты медленно начинает рассеиваться, пока вы начинаете дышать легче. Все кончено."
	image =       "quests/quest-image.jpg"
	time_limit =  80.0

	requirements = {
		xp_level = 8
	}

	phases = [
		{
			id = "PHASE_0"
			reward_xp = 2500
			goals = [
				{
					id = "KILL"
					description = "Убить [VAR.required_amount] минометные капсулы."
					actor_type_id_0 = "actors/enemies/mortarpod.xml"
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

