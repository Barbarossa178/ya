quest <- {
	category =    "CHALLENGE"
	name =        "Одинокая дорога"
	description = "Ходьба и бег могут быть вознаграждены."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					id = "GOAL_0_WALK"
					description = "Идите пешком [VAR.required_amount] метров."
					required_amount = 200

					function OnInitialize()
					{
						local distance_at_start = GetPersistentInteger("distance_at_start", Game_GetStatisticsAsInteger("distance_travelled"));
						SetPersistentInteger("distance_at_start", distance_at_start);
					}

					function GetProgressText()
					{
						local distance_at_start = GetPersistentInteger("distance_at_start", 0);
						local distance_now = Game_GetStatisticsAsInteger("distance_travelled");
						local distance_moved = distance_now - distance_at_start;
						if (distance_moved >= this.required_amount)
						{
							distance_moved = this.required_amount;
							SetCurrentPhaseGoalCompletedById(id);
						}
						return distance_moved + "/" + this.required_amount;
					}
				}
				{
					id = "GOAL_1_RUN"
					description = "Пробегите [VAR.required_amount] метров."
					required_amount = 1000

					function OnInitialize()
					{
						local distance_at_start = GetPersistentInteger("distance_at_start", Game_GetStatisticsAsInteger("distance_travelled"));
						SetPersistentInteger("distance_at_start", distance_at_start);
					}

					function GetProgressText()
					{
						local distance_at_start = GetPersistentInteger("distance_at_start", 0);
						local distance_now = Game_GetStatisticsAsInteger("distance_travelled");
						local distance_moved = distance_now - distance_at_start;
						if (distance_moved >= this.required_amount)
						{
							distance_moved = this.required_amount;
							SetCurrentPhaseGoalCompletedById(id);
						}
						return distance_moved + "/" + this.required_amount;
					}
				}
			]
		}
	]
}

function Initialize()
{
	if (quest.phases[0].goals[0].rawget("OnInitialize") != null)
		quest.phases[0].goals[0].OnInitialize();
}

function GetGoalProgress(phase_index, goal_index)
{
	return quest.phases[phase_index].goals[goal_index].GetProgressText();
}

