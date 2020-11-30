quest <- {
	category =    "CHALLENGE"
	name =        "Link Tower Challenge"
	description = "Locate link towers and activate them."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					id = "GOAL_0_0"
					description = "Activate [VAR.required_amount] link towers."
					required_amount = 3
				}
			]
		}
		{
			id = "PHASE_1"
			description = ""
			reward_xp = 1000
			goals = [
				{
					id = "GOAL_1_0"
					description = "Activate [VAR.required_amount] link towers."
					required_amount = 6
				}
			]
		}
		{
			id ="PHASE_2"
			description = ""
			reward_xp = 2000
			goals = [
				{
					id = "GOAL_2_0"
					description = "Activate [VAR.required_amount] link towers."
					required_amount = 10
				}
			]
		}
	]
}


function GetGoalProgress(phase_index, goal_index)
{
	local required_amount = quest.phases[phase_index].goals[goal_index].required_amount;
	local num_towers_activated = GetPersistentInteger("num_towers_activated", 0);

	return num_towers_activated + "/" + required_amount;
}

function OnTowerActivated(tower_id)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	local num_towers_activated = GetPersistentInteger("num_towers_activated", 0) + 1;
	SetPersistentInteger("num_towers_activated", num_towers_activated);

	local goal_index = 0;

	local required_amount = quest.phases[current_phase_index].goals[goal_index].required_amount;
	UpdateCurrentPhaseProgress(num_towers_activated.tofloat() / required_amount);

	if (num_towers_activated >= required_amount)
	{
			SetCurrentPhaseGoalCompleted(goal_index);
	}
}
