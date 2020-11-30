quest <- {
	category =    "TEMPORAL_CHALLENGE"
	name =        "Only a Northern Throng"
	description = "The rocky passage you are traversing seems suspiciously quiet. The perfect place for an ambush."
	description_when_completed = "There is blood on the snow, luckily it is not yours."
	image =       "quests/quest-image.jpg"
	time_limit =  75.0

	requirements = {
		xp_level = 10
	}

	phases = [
		{
			id = "PHASE_0"
			reward_xp = 3500
			goals = [
				{
					id = "KILL"
					description = "Kill [VAR.required_amount] the ambushers!"
					actor_type_id_0 = "actors/enemies/ex-human-fast-chaser.xml"
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
					description = "Finish in [VAR.temporal_challenge_time_limit] seconds."
					time_limited = true
				}
			]
		}
	]
}

