#include <sourcemod>
#include <sdktools>

#pragma semicolon	1
#pragma newdecls required

bool g_bGameInProgress;

public Plugin myinfo = 
{
	name = "Break Stuff",
	author = "FAILdows",
	description = "Commands to break glass and graves",
	version = "1.0",
	url = "https://github.com/ericwong3/l4d2-plugins"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_breakglass", Command_BreakGlass, "Breaks all glasses");
	RegConsoleCmd("sm_breakgraves", Command_BreakGraves, "Breaks all graves");
	
	HookEvent("survival_round_start", Event_OnSurvivalStart);
	HookEvent("round_start", Event_OnRoundStart);
	HookEvent("round_end", Event_OnRoundEnd);
	
	g_bGameInProgress = false;
}

public Action Command_BreakGlass(int client, int args)
{
	if (g_bGameInProgress)
	{
		ReplyToCommand(client, "[SM] Not allowed to use while round in progress.");
		return Plugin_Handled;
	}
	
	int ent = -1;
	while ((ent = FindEntityByClassname(ent, "func_breakable")) != -1)
	{
		if (IsValidEntity(ent)) {
      int iMaterial = GetEntProp(ent, Prop_Data, "m_Material");

      if (iMaterial == 0) { // Glass. Ref: https://twhl.info/wiki/page/func_breakable
        AcceptEntityInput(ent, "Break");
      }
    }
	}
	
	return Plugin_Handled;
}

public Action Command_BreakGraves(int client, int args)
{
	if (g_bGameInProgress)
	{
		ReplyToCommand(client, "[SM] Not allowed to use while round in progress.");
		return Plugin_Handled;
	}
	
	int ent = -1;
	while ((ent = FindEntityByClassname(ent, "prop_physics")) != -1)
	{
		char sModel[PLATFORM_MAX_PATH];
    GetEntPropString(ent, Prop_Data, "m_ModelName", sModel, sizeof(sModel));

    if (StrContains(sModel, "/grave_") != -1) {
      AcceptEntityInput(ent, "Break");
    }
	}
	
	return Plugin_Handled;
}

public void Event_OnSurvivalStart(Event event, const char[] name, bool dontBroadcast)
{
	g_bGameInProgress = true;
}

public void Event_OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	g_bGameInProgress = false;
}

public void Event_OnRoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	g_bGameInProgress = false;
}
