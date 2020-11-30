quest <- {
	category =    "CHALLENGE"
	name =        "Ancient Tombs"
	description = "These tombs must contain treasures of great value. I should check them out."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "TOMB_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					id = "GOAL_0_0"
					description = "Complete [VAR.required_tombs] tombs."
					required_tombs = 3
				}
			]
		}
		{
			id = "TOMB_1"
			description = ""
			reward_xp = 2000
			goals = [
				{
					id = "GOAL_1_0"
					description = "Complete [VAR.required_tombs] tombs."
					required_tombs = 7
				}
			]
		}
		{
			id ="TOMB_2"
			description = ""
			reward_xp = 5000
			goals = [
				{
					id = "GOAL_2_0"
					description = "Complete [VAR.required_tombs] tombs."
					required_tombs = 13
				}
			]
		}
		{
			id ="TOMB_3"
			description = ""
			reward_xp = 8000
			goals = [
				{
					id = "GOAL_3_0"
					description = "Complete [VAR.required_tombs] tombs."
					required_tombs = 20
				}
			]
		}
	]
}


function GetGoalProgress(phase_index, goal_index)
{
	local num_required_tombs = quest.phases[phase_index].goals[goal_index].required_tombs;
	local num_tombs_completed = GetPersistentInteger("num_tombs_completed", 0);

	return num_tombs_completed + "/" + num_required_tombs;
}

function OnTombCompleted(tomb_id)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	local num_tombs_completed = GetPersistentInteger("num_tombs_completed", 0) + 1;
	SetPersistentInteger("num_tombs_completed", num_tombs_completed);

	local num_required_tombs = quest.phases[current_phase_index].goals[0].required_tombs;
	if (num_tombs_completed >= num_required_tombs)
	{
		SetCurrentPhaseGoalCompleted(0);
	}
}
