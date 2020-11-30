quest <- {
	category =    "CHALLENGE"
	name =        "Treasure Bags"
	description = "Trashes of the old world can contain very useful materials."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					id = "GOAL_0_0"
					description = "Break and loot trash bags"
					actor_type_id = "actors/objects/suburb-trash-bag.xml"
					required_amount = 9

					function OnActorStartDying(actor)
					{
						local destroyed_actor_type = Actor_GetActorType(actor);
						if (destroyed_actor_type == this.actor_type_id)
						{
							local num = GetPersistentInteger("num_destroyed", 0) + 1;
							SetPersistentInteger("num_destroyed", num);
							if (num >= this.required_amount)
								SetCurrentPhaseGoalCompleted(0);
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
