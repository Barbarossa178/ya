quest <- {
	category =    "TEMPORAL_CHALLENGE"
	name =        "Охота на стаи волков"
	description = "Голодный вой эхом отзывается на ледяном ветру. Вой все ближе."
	description_when_completed = "Последний скул угасает и наступает тишина."
	image =       "quests/quest-image.jpg"
	time_limit =  65.0

	requirements = {
		xp_level = 8
	}

	phases = [
		{
			id = "PHASE_0"
			reward_xp = 3000
			goals = [
				{
					id = "KILL"
					description = "Убить[VAR.required_amount] волков"
					actor_type_id_0 = "actors/enemies/ex-animal-wolf.xml"
					required_amount = 4

					function OnInitialize()
					{
					}

					function OnActorStartDying(actor)
					{
						if (!StageObject_HasTag(actor, "QUEST_TARGET"))
							return;

						local destroyed_actor_type = Actor_GetActorType(actor);
						if (destroyed_actor_type == this.actor_type_id_0)
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

