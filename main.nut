quest <- {
	category =    "MAIN_QUEST"
	name =        "Сбежать с острова"
	description = "Найди способ сбежать из этого ужасного места."
	image =       "quests/quest-image.jpg"

	phases = [
		{   // Phase 0
			id = "GO_TO_EVACUATION_SITE"
			reward_xp = 1000
			goals = [
				{
					id = "GO"
					description = "Отправляйтесь на место эвакуации [GREEN]к востоку[WHITE] от вашего убежища."
					quest_marker_stage_object_id = "EVACUATION_SITE_ENTRANCE"

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
						{
							SetCurrentPhaseGoalCompletedById(id);
						}
					}
				}
			]
		}

		{   // Phase 0.1
			id = "INVESTIGATE_EVACUATION_SITE"
			description = "Осмотрите место эвакуации."
			goals = [
				{
					id = "EXAMINE_GATE"
					description = "Осмотрите место эвакуации."
					quest_marker_stage_object_id = "EVACUATION_SITE_INNER_GATE"

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
						{
							SetCurrentPhaseGoalCompletedById(id);
						}
					}
				}
			]
		}

		{   // Phase 0.2
			id = "SCAN_FOR_RELAYS"
			description = "Откройте ворота, чтобы получить доступ к стартовым площадкам."
			reward_xp = 1000
			goals = [
				{
					id = "SCAN"
					description = "Откройте Внутренние ворота."
					quest_marker_stage_object_id = "evac_inner_gate_terminal"
				}
			]
		}

		{   // Phase 0.3
			id = "ACTIVATE_RELAYS"
			description = "Сеть должна быть подключена к сети, чтобы открыть ворота."
			reward_xp = 2500
			goals = [
				/*{
					id = "ACTIVATE_RELAYS"
					required_amount = 4
					description = "Активируйте реле."

					function GetNumberOfRelaysActivated()
					{
						local num = 0;
						if (Game_GetWorldState("MAIN_QUEST", "LINK_RELAY_0") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "LINK_RELAY_1") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "LINK_RELAY_2") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "LINK_RELAY_3") != null) num++;
						return num;
					}

					function GetProgressText()
					{
						local num = GetPersistentInteger("num_relays");
						if (num > this.required_amount)
							num = this.required_amount;
						return num + "/" + this.required_amount;
					}

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
						{
							local num = GetNumberOfRelaysActivated();
							SetPersistentInteger("num_relays", num);
							CheckCompletion();
						}
					}

					function CheckCompletion()
					{
						local num = GetPersistentInteger("num_relays");
						if (num >= this.required_amount)
							SetCurrentPhaseGoalCompletedById(id);
					}
					quest_marker_stage_object_id = "LINK_RELAY_0"
				}*/

				{
					id = "ACTIVATE_RELAY_2"
					quest_marker_stage_object_id = "LINK_RELAY_2"
					description = "The Fishing Relay"

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
							CheckCompletion();
					}

					function CheckCompletion()
					{
						if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
				{
					id = "ACTIVATE_RELAY_1"
					quest_marker_stage_object_id = "LINK_RELAY_1"
					description = "The Farm Relay"

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
							CheckCompletion();
					}

					function CheckCompletion()
					{
						if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
				{
					id = "ACTIVATE_RELAY_0"
					quest_marker_stage_object_id = "LINK_RELAY_0"
					description = "The Park Relay"

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
							CheckCompletion();
					}

					function CheckCompletion()
					{
						if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
				{
					id = "ACTIVATE_RELAY_3"
					quest_marker_stage_object_id = "LINK_RELAY_3"
					description = "The Graveyard Relay"

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
							CheckCompletion();
					}

					function CheckCompletion()
					{
						if (Game_GetWorldState("MAIN_QUEST", quest_marker_stage_object_id) != null)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
				{
					id = "OPEN_GATE"
					description = "Open the gate."
					quest_marker_stage_object_id = "evac_inner_gate_terminal"
				}
			]
		}

		{   // Phase 1
			id = "INVESTIGATE_EVACUATION_SITE_FIND_POD"
			description = "Investigate the evacuation site."
			reward_xp = 1000
			goals = [
				{
					id = "EXAMINE_ESCAPE_POD"
					description = "Find an [GREEN]Escape Pod[WHITE]."
					quest_marker_stage_object_id = "ESCAPE_POD"
				}
			]
		}

		{   // Phase 2
			id = "INVESTIGATE_LINK_TOWER"
			description = "Investigate the evacuation site."
			goals = [
				{
					id = "SCAN_FOR_FUEL_CELLS"
					description = "Use the [GREEN]Link Tower[WHITE] to scan for [GREEN]Fuel Cells[WHITE]."
					quest_marker_stage_object_id = "TOWER_E_SHORE"
				}
			]
		}

		{   // Phase 3
			id ="FIND_FUEL_CELLS"
			description = "Find and collect [GREEN]Fuel Cells[WHITE] for the escape pod."
			goals = [
				{
					id = "FIND_FULL_CELLS"
					material_id = "FUEL_CELL"
					required_amount = 4
					description = "Find [VAR.required_amount] x [MATERIAL_ICON=FUEL_CELL] Fuel Cells."
					quest_marker_stage_object_id = "BOSS_LAW,BOSS_REAPER,BOSS_SWORD,BOSS_CROWN"

					function IsBossKilled(id)
					{
						return Game_GetWorldState("BOSS", "killed_" + id) != null;
					}

					function ShouldShowQuestMarker(stage_object_id)
					{
						local num_fuel_cells_collected = GetPersistentInteger("num_collected");
						if (num_fuel_cells_collected == null || num_fuel_cells_collected < 2)
						{
							if (stage_object_id == "BOSS_SWORD")
								return false;
							if (stage_object_id == "BOSS_CROWN")
								return false;
						}

						if (IsBossKilled(stage_object_id))
							return false;

						return true;
					}

					function GetNumberOfFuelCellsInstalled()
					{
						local num = 0;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_1") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_2") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_3") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_4") != null) num++;
						return num;
					}

					function GetProgressText()
					{
						local num = GetPersistentInteger("num_fuel_cells");//Game_GetNumberOfMaterialsStoragePlusCarried(this.material_id) + GetNumberOfFuelCellsInstalled();
						if (num > this.required_amount)
							num = this.required_amount;
						return num + "/" + this.required_amount;
					}

					function OnCollectedMaterial(so_material, so_collector)
					{
						local material_id = StageObject_GetKeyValue(so_material, "material_id");
						if (material_id == "FUEL_CELL")
						{
							local num_materials_collected = GetPersistentInteger("num_fuel_cells", 0) + 1;
							SetPersistentInteger("num_fuel_cells", num_materials_collected);
							CheckCompletion();
						}
					}

					function CheckCompletion()
					{
						local num = GetPersistentInteger("num_fuel_cells");//Game_GetNumberOfMaterialsStoragePlusCarried(this.material_id) + GetNumberOfFuelCellsInstalled();

						local num_collected = GetPersistentInteger("num_collected");
						if (num_collected == null)
							num_collected = 0;

						if (num != num_collected)
						{
							SetPersistentInteger("num_collected", num);
							if (num == 2)
							{
								local version = NX_GetProgramVersionString();
								UI_ShowPopup("Current Early Access Version Limit Reached", "After installing the second |#11ff11|Fuel Cell|#ffffff|, you have completed as much of the |#11ff11|Main Quest|#ffffff| as you can in this version " + version + ".\n\nWhile waiting for the next bigger update, you can complete the |#11ff11|Side Quests|#ffffff| and |#11ff11|Points of Interests|#ffffff|. You can also toughen up for the upcoming challenges by inventing and crafting better gear. Good luck!");
							}
						}

						if (num >= this.required_amount)
							SetCurrentPhaseGoalCompletedById(id);
					}
				}
			]
		}

		{   // Phase 3
			id = "INSTALL_FUEL_CELLS"
			description = "Install [GREEN]Fuel Cells[WHITE] to the escape pod."
			goals = [
				{
					id = "INSTALL_FUEL_CELLS"
					description = "Install the Fuel Cells."
					required_amount = 4
					quest_marker_stage_object_id = "ESCAPE_POD"

					function GetNumberOfFuelCellsInstalled()
					{
						local num = 0;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_1") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_2") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_3") != null) num++;
						if (Game_GetWorldState("MAIN_QUEST", "INSTALLED_FUEL_CELL_4") != null) num++;
						return num;
					}

					function GetProgressText()
					{
						return GetNumberOfFuelCellsInstalled() + "/" + this.required_amount;
					}

					function CheckCompletion()
					{
						local num = GetNumberOfFuelCellsInstalled();

						local num_installed = GetPersistentInteger("num_installed");
						if (num_installed == null)
							num_installed = 0;

						if (num != num_installed)
						{
							SetPersistentInteger("num_installed", num);
						}

						if (num >= this.required_amount)
							SetCurrentPhaseGoalCompletedById(id);
					}

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
						{
							CheckCompletion();
						}
					}
				}
			]
		}

		/*{   // Phase 4
			id = "SOMETHING_SURPRISING"
			description = "Go to the evacuation site marked on your [GREEN]map[WHITE]."
			goals = [
				{
					id = "INSTALL_POWER_SOURCES"
					description = "Some phase just before you should be onboarding. Something goes wrong? Fight some zombies while trying to onboard?"
					quest_marker_stage_object_id = "SOMETHING"

					function CheckCompletion()
					{
						return false;
					}
				}
			]
		}*/

		{   // Phase 5
			id = "ONBOARD_THE_ESCAPE_POD"
			description = "Go to the evacuation site marked on your [GREEN]map[WHITE]."
			reward_string = "???"
			goals = [
				{
					id = "ONBOARD"
					description = "Onboard the Escape Pod."
					quest_marker_stage_object_id = "ESCAPE_POD"
				}
			]
		}
	]
}


function CheckAllCurrentQuestGoals()
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);
	foreach (goal in quest.phases[current_phase_index].goals)
	{
		if ("CheckCompletion" in goal && goal.CheckCompletion())
		{
			SetCurrentPhaseGoalCompletedById(goal.id);
		}
	}
}

function Initialize()
{
	CheckAllCurrentQuestGoals();
}

function OnCollectedMaterial(so_material, so_collector)
{
	local current_phase_index = Game_GetQuestPhaseIndex(quest_id);
	foreach (goal in quest.phases[current_phase_index].goals)
	{
		if ("CheckCompletion" in goal && goal.CheckCompletion())
		{
			CheckAllCurrentQuestGoals();
		}
	}
}
