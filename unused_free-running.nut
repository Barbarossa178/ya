quest <- {
	category =    "TEMPORAL_CHALLENGE"
	name =        "Свободный забег"
	description = "Я становлюсь более опытным в освоении острова. Возможно, мне стоит проверить свою скорость с помощью небольшого теста, так как быстрое передвижение очень важно для выживания!"
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
					description = "Доберитесь до [GREEN]первого чекпоинта[WHITE]."
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
					description = "Доберитесь до [GREEN]второго чекпоинта[WHITE]."
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
					description = "Доберитесь до [GREEN]последнего чекпоинта[WHITE]."
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
