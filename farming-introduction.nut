quest <- {
	category =    "SIDE_QUEST"
	name =        "Основы земледелия"
	description = "Следует обратить внимание на сельское хозяйство, так как выращивание культур может помочь вам получить больше ингредиентов для еды."
	description_when_completed = "The first harvest is succesful and promises a perpetual source of sustenance."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 1000

			goals = [

				{
					id = "SEED_BAG"
					description = "Иследовать и создать  [GREEN]Пакет с Семенами[WHITE]."

					function OnInitialize()
					{
						Game_SetRecipeUnlocked("SEED_BAG", true);
						CheckProgress();
					}

					function OnUpdate(tdelta)
					{
						CheckProgress();
					}

					function CheckProgress()
					{
						if (Game_IsRecipeCrafted("SEED_BAG"))
							SetCurrentPhaseGoalCompletedById(id);
					}
				}

				{
					id = "PLANT_A_SEED"
					description = "Посадите [GREEN]Семена[WHITE]."

					function OnInitialize()
					{
						CheckProgress();
					}

					function OnCommandWord(command)
					{
						if (command == "plant_seed")
							SetCurrentPhaseGoalCompletedById(id);
					}

					function CheckProgress()
					{
					}
				},

				{
					id = "HARVEST_CROPS"
					description = "Собрать [GREEN]Урожай[WHITE]."
					function OnInitialize()
					{
						CheckProgress();
					}
					function OnUpdate(tdelta)
					{
						CheckProgress();
					}
					function CheckProgress()
					{
					}

					function OnActorStartDying(actor)
					{
						NX_Print("tags ");
						if (StageObject_HasTag(actor, "HARVESTABLE"))
							SetCurrentPhaseGoalCompletedById(id);
					}

					function OnActorInteraction(interactive_actor, interactor_actor, interarction_id)
					{
						if (interarction_id == "harvest")
							SetCurrentPhaseGoalCompletedById(id);
					}
				},

			]
		}
	]
}
