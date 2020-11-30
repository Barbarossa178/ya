quest <- {
	category =    "CHALLENGE"
	name =        "Отголоски прошлого"
	description = "Какая-то старая радиостанция все еще вещает. Может быть, трансляции могут дать мне подсказки о том, что именно случилось."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "PHASE_0"
			description = ""
			reward_xp = 1000
			goals = [
				{
					id = "LISTEN"
					description = "Слушайте [VAR.required_amount] радио."
					required_amount = 2

					function OnInitialize()
					{
						CheckProgress();
					}

					function CheckProgress()
					{
						local num = Game_GetNumberOfCollectiblesInCategoryFound("RADIO_BROADCASTS");
						SetPersistentInteger("num_radios", num);
						if (num >= this.required_amount)
							SetCurrentPhaseGoalCompletedById(id);
					}

					function OnCommandWord(command_word)
					{
						if (command_word == "activate")
						{
							CheckProgress();
						}
					}

					function GetProgressText()
					{
						local num = GetPersistentInteger("num_radios", 0);
						return num + "/" + this.required_amount;
					}
				}
			]
		}
	]
}

function OnQuestCompleted()
{
	local so_player = Game_GetPrimaryPlayerActor();
	Game_AddActorNotification(so_player, "Интересно, что случилось. [EMOJI=thinking face]");
}
