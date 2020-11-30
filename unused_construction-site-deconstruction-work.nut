quest <- {
	category =    "CHALLENGE"
	name =        "Deconstruction work"
	description = "The construction site is overrun by ex-humans. I better clear up the area to salvage the materials within safely."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					/* Set targets by adding Stage Object Refence called "target_x" (0-5 in this case) that has targets as values.*/
					id = "KILL"
					description = "Kill [VAR.required_amount] ex-humans"
					actor_type_id = "actors/enemies/ex-human-female-melee.xml"
					actor_type_id_2 = "actors/enemies/ex-human-male-melee.xml"
					actor_type_id_3 = "actors/enemies/ex-human-puker.xml"
					required_amount = 6

					function OnActorStartDying(actor)
					{
						local destroyed_actor_type = Actor_GetActorType(actor);
						if (destroyed_actor_type == this.actor_type_id ||
							destroyed_actor_type == this.actor_type_id_2 ||
							destroyed_actor_type == this.actor_type_id_3)
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
