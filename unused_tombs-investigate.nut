quest <- {
	category =    "CHALLENGE"
	name =        "Каменные сооружения"
	description = "Из древних каменных образований исходит странный свет. Я должен исследовать их больше."
	image =       "quests/quest-image.jpg"

	phases = [
		{
			id = "INVESTIGATE"
			description = ""
			reward_xp = 950
			goals = [
				{
					id = "GOAL_INVESTIGATE"
					description = "Изучите [VAR.required_amount] каменные образования."
					required_amount = 3

					function GetProgressText()
					{
						local num = GetPersistentInteger("num", 0);
						return num + "/" + this.required_amount;
					}
				}
			]
		}
	]
}

function OnActorInteraction(interactive_actor, interactor_actor, interaction_id)
{
	if (interaction_id != "investigate" &&
		interaction_id != "quest_accepted")
		return;

	if (Actor_GetActorType(interactive_actor) != "actors/objects/tomb-entrance-on-ground.xml")
		return;

	local num_investigated = GetPersistentInteger("num_investigated", 0);

	local tombs_investigated = GetPersistentString("tombs_investigated", "");

	local marker_string = StageObject_GetPersistentUniqueId(interactive_actor).tostring();

	if (string_contains_token(tombs_investigated, marker_string))
	{
		if (interaction_id == "investigate")
		{
			local text_0 = "Я уже исследовал это.";
			Game_AddActorNotification(interactor_actor, LocalizeText(text_0));
		}
		return;
	}

	local tokens = string_tokenize(tombs_investigated);

	tombs_investigated = tombs_investigated + marker_string + ",";
	SetPersistentString("tombs_investigated", tombs_investigated);

	local num_investigated = tokens.len() + 1;

	if (num_investigated >= quest.phases[0].goals[0].required_amount)
		SetCurrentPhaseGoalCompletedById("GOAL_INVESTIGATE");

	SetPersistentInteger("num", num_investigated);

	if (num_investigated == 1)
	{
		local text_0 = "Я помню эти древние каменные образования.";
		local text_1 = "Похоже, никто не знает, для чего они нужны.";
		Game_AddActorNotification(interactor_actor, LocalizeText(text_0));
		Game_AddActorNotification(interactor_actor, LocalizeText(text_1));
		return;
	}

	if (num_investigated == 2)
	{
		local text_0 = "Думаю, это какие-то гробницы.";
		local text_1 = "Они выглядят как-то по-другому";
		Game_AddActorNotification(interactor_actor, LocalizeText(text_0));
		Game_AddActorNotification(interactor_actor, LocalizeText(text_1));
		return;
	}

	if (num_investigated == 3)
	{
		Actor_InteractWithInteraction(interactive_actor, interactor_actor, "unlock");
		local text_0 = "Что происходит [EMOJI=hushed face]";
		Game_AddActorNotification(interactor_actor, LocalizeText(text_0));
		return;
	}

}
