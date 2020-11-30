quest <- {
	category =    "CHALLENGE"
	name =        "Thinning the Horde"
	description = "They're all around us. Kill some ex-humans."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					id = "KILL"
					description = "Kill [VAR.required_amount] ex-humans"
					actor_type_id = "actors/enemies/ex-human-female-melee.xml"
					actor_type_id_2 = "actors/enemies/ex-human-male-melee.xml"
					required_amount = 4

					function OnActorStartDying(actor)
					{
						local destroyed_actor_type = Actor_GetActorType(actor);
						if (destroyed_actor_type == this.actor_type_id ||
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
			]
		}
	]
}
