quest <- {
	category =    "CHALLENGE"
	name =        "Основные нужды"
	description = "Некоторое элементарное снаряжение необходимо для того, чтобы иметь возможность выжить."
	description_when_completed = "Это начало долгого пути, но, к счастью, основы уже заложены."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 1000

			goals = [
				{
					id = "MAP"
					description = "Найти [GREEN]карту[WHITE] в [ORANGE]Башню связи[WHITE]."

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
						if (Game_IsFeatureAvailable("MAP"))
							SetCurrentPhaseGoalCompletedById(id);
					}
				},

				{
					id = "BACKPACK"
					description = "Модернизируйте свой [GREEN]Рюкзак[WHITE]."

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
						if (Game_GetRecipeUpgradeLevel("BACKPACK") >= 1)
							SetCurrentPhaseGoalCompletedById(id);
					}
				},

				{
					id = "LEVEL_UP"
					description = "Повысить уровень."

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
						local xp = Game_GetExperiencePoints();
						local req_xp = Game_GetExperiencePointsRequiredForLevel(2);
						if (xp >= req_xp)
							SetCurrentPhaseGoalCompletedById(id);
					}

					function GetProgressText()
					{
						local xp = Game_GetExperiencePoints();
						local req_xp = Game_GetExperiencePointsRequiredForLevel(2);
						return xp + "/" + req_xp;
					}
				}
			]
		}
	]
}

function OnQuestAccepted()
{
	Game_SetRecipeTracked("BACKPACK", true);
}
