quest <- {
	category =    "CHALLENGE"
	name =        "Ломом через препятствия"
	description = "Модернизируйте лом и проламывайте препятствия."
	description_when_completed = "Теперь путь открыт для дальнейших действий."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 600
			goals = [
				{
					id = "GOAL_0_MATERIALS"
					description = "Найти [VAR.required_amount]x[MATERIAL_ICON=[VAR.material_id]] [MATERIAL_NAME=[VAR.material_id]]"
					material_id = "SCRAP_METAL"
					required_amount = 2

					function GetProgressText()
					{
						local num = max(Game_GetNumberOfMaterialsStoredAllTime(this.material_id), Game_GetNumberOfMaterialsStoragePlusCarried(this.material_id));
						if (num > this.required_amount)
							num = this.required_amount;
						return num + "/" + this.required_amount;
					}

					function CheckCompletion()
					{
						local num = max(Game_GetNumberOfMaterialsStoredAllTime(this.material_id), Game_GetNumberOfMaterialsStoragePlusCarried(this.material_id));
						return (num >= this.required_amount);
					}
				}
				{
					id = "GOAL_0_MATERIALS_WOOD"
					description = "Найти [VAR.required_amount]x[MATERIAL_ICON=[VAR.material_id]] [MATERIAL_NAME=[VAR.material_id]]"
					material_id = "WOOD"
					required_amount = 5

					function GetProgressText()
					{
						local num = max(Game_GetNumberOfMaterialsStoredAllTime(this.material_id), Game_GetNumberOfMaterialsStoragePlusCarried(this.material_id));
						if (num > this.required_amount)
							num = this.required_amount;
						return num + "/" + this.required_amount;
					}

					function CheckCompletion()
					{
						local num = max(Game_GetNumberOfMaterialsStoredAllTime(this.material_id), Game_GetNumberOfMaterialsStoragePlusCarried(this.material_id));
						return (num >= this.required_amount);
					}
				}
				{
					id = "GOAL_1_UPGRADE"
					description = "Модернизируйте лом в лагере"
					recipe_id = "CROWBAR"
					num_required_upgrades = 1

					function CheckCompletion()
					{
						return (Game_GetRecipeUpgradeLevel(this.recipe_id) >= 1);
					}
				}
				{
					id = "GOAL_2_OBSTACLE"
					description = "Уничтожить преграду"
					actor_id = "TUTORIAL_DRESSER"

					function CheckCompletion()
					{
						local so = StageObject_GetById(actor_id);
						return so == null || so == 0;
					}
				}
			]
		}
	]
}


function Initialize()
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);
	foreach (goal in quest.phases[current_phase_index].goals)
	{
		if (goal.CheckCompletion())
		{
			SetCurrentPhaseGoalCompletedById(goal.id);
		}
	}
}

function CheckAllGoalCompletions()
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	foreach (goal in quest.phases[current_phase_index].goals)
	{
		if (goal.CheckCompletion())
		{
			SetCurrentPhaseGoalCompletedById(goal.id);
		}
	}
}

function OnCollectedMaterial(so_material, so_collector)
{
	CheckAllGoalCompletions();
}

function OnUpgradedCraftedRecipe(recipe_id)
{
	CheckAllGoalCompletions();
}

function OnActorStartDying(actor)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);

	local goal_index = 3;
	if (StageObject_GetId(actor) == quest.phases[current_phase_index].goals[goal_index].actor_id)
		SetCurrentPhaseGoalCompleted(goal_index);
	else
		CheckAllGoalCompletions();
}
