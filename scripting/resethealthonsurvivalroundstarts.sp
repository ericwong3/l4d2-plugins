#pragma newdecls required

#define VERSION "1.0a"

public Plugin myinfo =
{
	name				= "[L4D2] Heal/Reset Survivor Health on Survival Round Starts",
	author			= "FAILdows",
	description = "Reset all survivors health to 100 when a survival round starts",
	version			= VERSION
}

public void OnPluginStart()
{
	HookEvent("survival_round_start", Event_SurvivalStart, EventHookMode_Pre);
}

public Action Event_SurvivalStart(Event event, const char[] name, bool dontBroadcast)
{
	char target_name[MAX_TARGET_LENGTH];
	int target_list[MAXPLAYERS];
	int target_count;
	bool tn_is_ml;

	if ((target_count = ProcessTargetString(
			"@all",
			0,
			target_list,
			MAXPLAYERS,
			COMMAND_FILTER_ALIVE,
			target_name,
			sizeof(target_name),
			tn_is_ml)) <= 0)
	{
		return Plugin_Handled;
	}

	for (int i = 0; i < target_count; i++)
	{
		if (GetClientTeam(target_list[i]) == 2) { // Survivor
			SetEntityHealth(target_list[i], 100);
			SetEntProp(target_list[i], Prop_Send, "m_currentReviveCount", 0); // Reset incpacitate count
			SetEntProp(target_list[i], Prop_Send, "m_bIsOnThirdStrike", 0); // Remove B+W
			SetEntProp(target_list[i], Prop_Send, "m_isIncapacitated", 0); // De-incpacitate
			SetEntPropFloat(target_list[i], Prop_Send, "m_healthBufferTime", GetGameTime())
			SetEntPropFloat(target_list[i], Prop_Send, "m_healthBuffer", 0.0); // Remove temp health
		}
	}

	return Plugin_Handled;
}
