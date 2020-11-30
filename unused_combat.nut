quest <- {
	category =    "CHALLENGE"
	name =        "Combat Challenge"
	description = "Combat challenge."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "COMBAT_0"
			description = ""
			reward_xp = 400
			goals = [
				{
					id = "GOAL_0_0"
					description = "Kill [VAR.required_kills] enemies."
					required_kills = 10
				}
			]
		}
		{
			id = "COMBAT_1"
			description = ""
			reward_xp = 5000
			goals = [
				{
					id = "GOAL_1_0"
					description = "Kill [VAR.required_kills] enemies by backstabbing."
					required_kills = 5
				}
			]
		}
		{
			id ="COMBAT_2"
			description = ""
			reward_xp = 8000
			goals = [
				{
					id = "GOAL_2_0"
					description = "Kill [VAR.required_kills] enemies within [VAR.time_in_seconds] seconds."
					required_kills = 3
					time_in_seconds = 3
				}
			]
		}
	]
}

local num_kills = 0;
local num_kills_by_backstabbing = 0;
local kill_times = [];

function Initialize()
{
	num_kills = GetPersistentInteger("num_kills", 0);
	num_kills_by_backstabbing = GetPersistentInteger("num_kills_by_backstabbing", 0);
}

function GetGoalProgress(phase_index, goal_index)
{
	switch (phase_index)
	{
	case 0:
		local num_required_kills = quest.phases[0].goals[goal_index].required_kills;
		return num_kills + "/" + num_required_kills;

	case 1:
		local num_required_kills = quest.phases[1].goals[goal_index].required_kills;
		return num_kills_by_backstabbing + "/" + num_required_kills;
	}

	return "";
}

function OnEnemyStartDying(so_actor, so_dealer, damage_flags, damage_type)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	if (StageObject_HasTag(so_actor, "ANIMAL"))
	{
		return;
	}

	num_kills++;
	SetPersistentInteger("num_kills", num_kills);

	if (damage_flags & DAMAGE_FLAG_BACKSTAB)
	{
		num_kills_by_backstabbing++;
		SetPersistentInteger("num_kills_by_backstabbing", num_kills_by_backstabbing);
	}

	local goal_index = 0;
	local goal = quest.phases[current_phase_index].goals[goal_index];
	if (goal.completed)
	{
		return;
	}

	switch (current_phase_index)
	{
	case 0:
		if (num_kills >= goal.required_kills)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
		}

		break;

	case 1:
		if (num_kills_by_backstabbing >= goal.required_kills)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
		}

		break;

	case 2:
		local kill_time = NX_GetTime();
		if (kill_times.len() > goal.required_kills)
		{
			kill_times.remove(0);
		}
		kill_times.push(kill_time);

		if (kill_times.len() == goal.required_kills)
		{
			local time_diff = kill_times[0] - kill_time;
			if (time_diff <= goal.time_in_seconds * 1000)
			{
				SetCurrentPhaseGoalCompleted(goal_index);
			}
		}

		break;
	}
}
