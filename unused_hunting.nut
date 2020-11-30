quest <- {
	category =    "CHALLENGE"
	name =        "Hunting Challenge"
	description = "Hunting challenge."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "HUNT_0"
			description = ""
			reward_xp = 400
			goals = [
				{
					id = "GOAL_0_0"
					description = "Hunt [VAR.required_kills] deer with a hunting rifle."
					required_kills = 1
				}
			]
		}
		{
			id = "HUNT_1"
			description = ""
			reward_xp = 3000
			goals = [
				{
					id = "GOAL_1_0"
					description = "Hunt [VAR.required_kills] deer."
					required_kills = 5
				}
			]
		}
		{
			id ="HUNT_2"
			description = ""
			reward_xp = 5000
			goals = [
				{
					id = "GOAL_2_0"
					description = "Hunt [VAR.required_kills] deer with an axe."
					required_kills = 1
				}
			]
		}
		{
			id = "HUNT_3"
			description = ""
			reward_xp = 5000
			goals = [
				{
					id = "GOAL_3_0"
					description = "Hunt [VAR.required_kills] deer."
					required_kills = 10
				}
			]
		}
		{
			id ="HUNT_4"
			description = ""
			reward_xp = 5000
			goals = [
				{
					id = "GOAL_4_0"
					description = "Hunt [VAR.required_kills] deer at once with an explosive."
					required_kills = 2
				}
			]
		}
		{
			id = "HUNT_5"
			description = ""
			reward_xp = 5000
			goals = [
				{
					id = "GOAL_5_0"
					description = "Hunt [VAR.required_kills] deer."
					required_kills = 20
				}
			]
		}
	]
}

local num_kills = 0;
local num_kills_with_rifle = 0;
local num_kills_with_axe = 0;
local explosion_kill_times = [];

function Initialize()
{
	num_kills = GetPersistentInteger("num_kills", 0);
	num_kills_with_rifle = GetPersistentInteger("num_kills_with_rifle", 0);
	num_kills_with_axe = GetPersistentInteger("num_kills_with_axe", 0);
}

function InitializeNewPhase()
{
	num_kills = 0;
	SetPersistentInteger("num_kills", num_kills);

	num_kills_with_axe = 0;
	SetPersistentInteger("num_kills_with_axe", num_kills_with_axe);

	num_kills_with_rifle = 0;
	SetPersistentInteger("num_kills_with_rifle", num_kills_with_rifle);

	explosion_kill_times.clear();
}

function GetGoalProgress(phase_index, goal_index)
{
	switch (phase_index)
	{
	case 0:
		local num_required_kills = quest.phases[phase_index].goals[goal_index].required_kills;
		return num_kills_with_rifle + "/" + num_required_kills;

	case 1:
	case 3:
	case 5:
		local num_required_kills = quest.phases[phase_index].goals[goal_index].required_kills;
		return num_kills + "/" + num_required_kills;

	case 2:
		local num_required_kills = quest.phases[phase_index].goals[goal_index].required_kills;
		return num_kills_with_axe + "/" + num_required_kills;
	}

	return "";
}

function OnEnemyStartDying(so_actor, so_dealer, damage_flags, damage_type)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	if (!StageObject_HasTag(so_actor, "ANIMAL")) // Only normal animals should have ANIMAL tag. Wolves are enemies.
	{
		return;
	}

	num_kills++;
	SetPersistentInteger("num_kills", num_kills);

	// TODO(mika): What is the best way to determine what the weapon was?
	if (damage_type == "PROJECTILE")
	{
		num_kills_with_rifle++;
		SetPersistentInteger("num_kills_with_rifle", num_kills_with_rifle);
	}
	else if (damage_type == "SLASHING")
	{
		num_kills_with_axe++;
		SetPersistentInteger("num_kills_with_axe", num_kills_with_axe);
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
		if (num_kills_with_rifle >= goal.required_kills)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
			InitializeNewPhase();
		}

		break;

	case 1:
	case 3:
	case 5:
		if (num_kills >= goal.required_kills)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
			InitializeNewPhase();
		}

		break;

	case 2:
		if (num_kills_with_axe >= goal.required_kills)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
			InitializeNewPhase();
		}

		break;

	case 4:
		if (damage_type == "EXPLOSIVE")
		{
			explosion_kill_times.push(NX_GetTime());
			while (explosion_kill_times.len() > 0 && explosion_kill_times[0] - explosion_kill_times.top() > 500)
			{
				explosion_kill_times.remove(0);
			}

			if (explosion_kill_times.len() >= goal.required_kills)
			{
				SetCurrentPhaseGoalCompleted(goal_index);
				InitializeNewPhase();
			}
		}

		break;
	}
}
