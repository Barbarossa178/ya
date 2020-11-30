quest <- {
	category =    "TEMPORAL_CHALLENGE"
	name =        "Free Running"
	description = "I am getting more adept at adventuring around the island. Perhaps I should test my speed with a little test as moving quickly is essential to survival!"
	image =       "quests/quest-image.jpg"
	time_limit =  45.0

	phases = [
		{
			id = "PHASE_1"
			description = ""
			goals = [
				{
					/* This phase needs a location marker with a location_id that corresponds with quest_location*/
					id = "GO_TO_FIRST_CHECKPOINT"
					description = "Get to [GREEN]First Checkpoint[WHITE]."
					quest_location = "RUN_2"

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
			goals = [
				{
					/* This phase needs a location marker with a location_id that corresponds with quest_location*/
					id = "GO_TO_SECOND_CHECKPOINT"
					description = "Get to [GREEN]Second Checkpoint[WHITE]."
					quest_location = "RUN_3"

					function OnEnterLocation(location_id, new_location)
					{
						if (location_id == quest_location)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
			]
		}
		{
			id = "PHASE_3"
			description = ""
			reward_xp = 1500
			goals = [
				{
					/* This phase needs a location marker with a location_id that corresponds with quest_location*/
					id = "GO_TO_FINAL_CHECKPOINT"
					description = "Get to [GREEN]Last Checkpoint[WHITE]."
					quest_location = "RUN_4"

					function OnEnterLocation(location_id, new_location)
					{
						if (location_id == quest_location)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
			]
		}

	]
}
