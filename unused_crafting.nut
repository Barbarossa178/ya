quest <- {
	category =    "CHALLENGE"
	name =        "Ремесленный процесс"
	description = "Создавайте новые предметы и модернизируйте их."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					id = "GOAL_0_0"
					description = "Улучшите лом."
					recipe_id = "items/tools/crowbar.nut"
					num_required_upgrades = 1
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
					description = "Изготовьте топор."
					recipe_id = "items/tools/axe.nut"
					num_required_upgrades = 0
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
					description = "Изготовьте кувалду."
					recipe_id = "items/tools/sledgehammer.nut"
					num_required_upgrades = 0
				}
			]
		}
	]
}


function GetGoalProgress(phase_index, goal_index)
{
	local num_required_upgrades = quest.phases[phase_index].goals[goal_index].num_required_upgrades;

	if (num_required_upgrades > 0)
	{
		local recipe_id = quest.phases[phase_index].goals[goal_index].recipe_id;
		local var_id = "num_upgrades_" + recipe_id;
		local num_upgrades = GetPersistentInteger(var_id, 0);
		return num_upgrades + "/" + num_required_upgrades;
	}

	return "";
}

function OnUpgradedCraftedRecipe(recipe_id)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	local var_id = "num_upgrades_" + recipe_id;
	local num_upgrades = GetPersistentInteger(var_id, 0) + 1;
	SetPersistentInteger(var_id, num_upgrades);

	foreach (goal_index, goal in quest.phases[current_phase_index].goals)
	{
		if (goal.completed || goal.recipe_id != recipe_id)
		{
			continue;
		}

		if (num_upgrades >= goal.num_required_upgrades)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
		}
	}
}

function OnCraftedRecipe(recipe_id)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	foreach (goal_index, goal in quest.phases[current_phase_index].goals)
	{
		if (goal.completed || goal.recipe_id != recipe_id)
		{
			continue;
		}

		if (goal.num_required_upgrades == 0)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
		}
	}
}
