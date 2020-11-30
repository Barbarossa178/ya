quest <- {
	category =    "CHALLENGE"
	name =        "Вызов сборщика материалов"
	description = "Есть много полезных материалов, которые можно найти. Я должен собрать их и использовать."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 500
			goals = [
				{
					id = "GOAL_0_0"
					description = "Собрать [VAR.required_amount] x [MATERIAL_ICON=[VAR.material_id]]"
					material_id = "PLANTS"
					required_amount = 10
				}
				{
					id = "GOAL_0_1"
					description = "Собрать [VAR.required_amount] x [MATERIAL_ICON=[VAR.material_id]]"
					material_id = "WOOD"
					required_amount = 5
				}
				{
					id = "GOAL_0_2"
					description = "Собрать [VAR.required_amount] x [MATERIAL_ICON=[VAR.material_id]]"
					material_id = "FABRIC"
					required_amount = 5
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
					description = "Собрать [VAR.required_amount] x [VAR.material_id]."
					material_id = "WOOD"
					required_amount = 30
				}
				{
					id = "GOAL_1_1"
					description = "Собрать [VAR.required_amount] x [VAR.material_id]."
					material_id = "METAL"
					required_amount = 30
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
					description = "Собрать [VAR.required_amount] x [VAR.material_id]."
					material_id = "FABRIC"
					required_amount = 10
				}
				{
					id = "GOAL_2_1"
					description = "Собрать [VAR.required_amount] x [VAR.material_id]."
					material_id = "PLASTICS"
					required_amount = 10
				}
			]
		}
		{
			id ="PHASE_3"
			description = ""
			reward_xp = 3000
			goals = [
				{
					id = "GOAL_3_0"
					description = "Собрать [VAR.required_amount] x [VAR.material_id]."
					material_id = "CACTUS"
					required_amount = 10
				}
				{
					id = "GOAL_3_1"
					description = "Собрать [VAR.required_amount] x [VAR.material_id]."
					material_id = "BRICKS"
					required_amount = 10
				}
			]
		}
	]
}


function GetGoalProgress(phase_index, goal_index)
{
	local required_amount = quest.phases[phase_index].goals[goal_index].required_amount;
	local material_id = quest.phases[phase_index].goals[goal_index].material_id;
	local num_materials_collected = GetPersistentInteger("num_materials_collected_" + material_id, 0);

	return num_materials_collected + "/" + required_amount;
}

function OnCollectedMaterial(so_material, so_collector)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	local old_progress = GetCurrentPhaseProgress();

	local material_id = StageObject_GetKeyValue(so_material, "material_id");
	local var_id = "num_materials_collected_" + material_id;
	local num_materials_collected = GetPersistentInteger(var_id, 0) + 1;
	SetPersistentInteger(var_id, num_materials_collected);

	local new_progress = GetCurrentPhaseProgress();
	if (new_progress > old_progress)
	{
		UpdateCurrentPhaseProgress(new_progress);
	}

	foreach (goal_index, goal in quest.phases[current_phase_index].goals)
	{
		if (!goal.completed && goal.material_id == material_id && num_materials_collected >= goal.required_amount)
		{
			SetCurrentPhaseGoalCompleted(goal_index);
		}
	}
}

function GetCurrentPhaseProgress()
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	local required_amount = 0.0;
	local collected_amount = 0.0;

	foreach (goal in quest.phases[current_phase_index].goals)
	{
		required_amount += goal.required_amount;
		collected_amount += min(goal.required_amount, GetPersistentInteger("num_materials_collected_" + goal.material_id, 0));
	}

	return collected_amount / required_amount;
}
